/**
 * Twee
 * @author Sreenath Somarajapuram
 */

package tiger.twee;

import haxe.io.Error;
import tiger.twee.easing.Quadratic;
import tiger.twee.interfaces.IEase;
import tiger.twee.interfaces.ITwee;

#if (flash || nme || openfl)
import flash.events.Event;
import flash.Lib;
#else
import haxe.Timer;
#end
	
class Tween implements ITwee{

	private static var _tweens:Array<Tween> = new Array<Tween>();
	private static var _tweensToDel:Array<Tween> = new Array<Tween>();
	private static var _prevTime:Int; // In millisec
	
	#if (!flash && !nme && !openfl)
	private static var _trigger:Timer;
	#end
		
	private var _target:Dynamic;
	private var _duration:Int;
	private var _tailedTwees:Array<ITwee>;
	private var _index:Int;
	private var _started:Bool = false;

	private var _toVars:Array<Float>;
	private var _fromVars:Array<Float>;
	private var _properties:Array<String>;
	private var _propCount:Int = 0;
	
	private var _toVarObj:Dynamic;
	private var _fromVarObj:Dynamic;

	private var _easing:IEase;
	private var _options:Dynamic;
	private var _repeat:Int;

	private var _timeElapsed:Int=0;
				
	public function new( target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic, options:Dynamic ){
			
		_target = target;
		_duration = Math.round(duration * 1000);
		_fromVarObj = fromVars;
		_toVarObj = toVars;
		
		//-------------Set Options
		if ( options!=null ) { _options = options; } else { _options = cast{}; }
		if ( _options.easing!=null ) { _easing = _options.easing; } else { _easing = Quadratic.easeOut; }
		if ( _options.repeat!=null ) { _repeat = _options.repeat; } else { _repeat = 1; }
		//-------------
			
		// Auto deactivation for tailed tweens
		if( !_options.inactive ) start();

	}
	
	public function start():Bool{
		if( _started ) return false; // Already active
		//if( _options.delay!=undefined ) ExUtils.delayedCall( add, _options.delay );
		else add();
		return true;
	}
	
	public function stop():Bool {
		return true;
	}
	
	private function add():Void{

		if ( !_target ) throw( "The instance was destroyed." );
		
		var propertyName:String;
		
		_properties = new Array<String>();
		_toVars = new Array<Float>();
		_fromVars = new Array<Float>();
		
		if( _fromVarObj && !_toVarObj ){
			for ( propertyName in Reflect.fields(_fromVarObj) ) {
				if( Reflect.getProperty(_target,propertyName)!=null ){
					_properties[ _propCount ] = propertyName;
					_fromVars[ _propCount ] = Reflect.getProperty(_fromVarObj,propertyName);
					_toVars[ _propCount++ ] = Reflect.getProperty(_target,propertyName);
				}
				else throw( "Property "+propertyName+" not found in target!" );
			}
		}
		else if( !_fromVarObj && _toVarObj ){
			for( propertyName in Reflect.fields(_toVarObj) ){
				if( Reflect.getProperty(_target,propertyName)!=null ){
					_properties[ _propCount ] = propertyName;
					_fromVars[ _propCount ] = Reflect.getProperty(_target,propertyName);
					_toVars[ _propCount++ ] = Reflect.getProperty(_toVarObj,propertyName);
				}
				else throw("Property "+propertyName+" not found in target!" );
			}
		}
		else{
			for(propertyName in Reflect.fields(_fromVarObj) ){
				if( Reflect.getProperty(_target,propertyName)!=null ){
					_properties[ _propCount ] = propertyName;
					_fromVars[ _propCount ] = Reflect.getProperty(_fromVarObj,propertyName);
					_toVars[ _propCount++ ] = Reflect.getProperty(_toVarObj,propertyName);
				}
				else throw( "Property "+propertyName+" not found in target!" );
			}
		}
			
		_index = _tweens.length;
		_tweens[ _index ] = this;
			
		if( _index==0 ){
			_prevTime = Lib.getTimer();
			
			#if (flash || nme || openfl)
			Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			#else
			_trigger = _trigger || new Timer(Std.int(1000 / 30));
			_trigger.run = onEnterFrame;
			#end
			
		}
		
		_started = true;
	}
	
	private function update( timeDelta:Int ):Void{
		if( _timeElapsed==_duration ){ // So that the callback is called in next frame.
			complete();
		}
		else{
			_timeElapsed += timeDelta;
			if( _timeElapsed>_duration ) _timeElapsed=_duration;

			updateProperties();
		}
	}
	
	private inline function updateProperties():Void {
		var fromVal:Float;
		for( i in 0..._propCount ) Reflect.setProperty(_target, _properties[i], _easing.compute( _timeElapsed, fromVal = _fromVars[i], _toVars[i]-fromVal, _duration ));
	}
	
	private inline function complete():Void {

		var tmp:Array<Float>;
		
		if( _repeat==1 ){
			if( Reflect.isFunction(_options.onComplete) ) _options.onComplete.apply( null, _options.onCompleteParams );
			if( _tailedTwees!=null ) for( i in 0..._tailedTwees.length ) _tailedTwees[i].start();
			destroy();
		}
		else{
			_repeat--;
			_timeElapsed = 0;
			if ( _options.tonfro==true ){ tmp = _toVars; _toVars = _fromVars; _fromVars = tmp; }
		}
		
	}
		
	public function tail( twee:ITwee ):Bool{
		if( _target==null ) return false;
		if( _tailedTwees==null ) _tailedTwees = new Array<ITwee>();
		_tailedTwees.push(twee);
		return true;
	}
		
	public function destroy():Void{
		if( _options ){
			_tweensToDel.push(this);
			
			//-------------Reset vars
			_options = null;
			_easing = null;
			
			_target = null;
			_tailedTwees = null;
				
			_toVars = null;
			_fromVars = null;
			_properties = null;
				
			_toVarObj = null;
			_fromVarObj = null;
				
			_easing = null;
			_options = null;

//			_duration = 0;
//			_index = 0;
//			_active = false;
//			_propCount;
//			_repeat = 0;
//			_timeElapsed = 0;
			//-------------
		}
	}
		
	public static function killTweensOf( target:Dynamic, complete:Bool ):Void{
		var tween:Tween;
		for( i in 0..._tweens.length ){
			tween = _tweens[i];
			if( tween._target == target ){
				if( complete && Reflect.isFunction(tween._options.onComplete) ) tween._options.onComplete.apply( null, tween._options.onCompleteParams );
				tween.destroy();
			}
		}
	}

	private static function onEnterFrame( #if (flash || nme || openfl) e:Event #end ):Void{
		var time:Int = Lib.getTimer();
		var timeDelta:Int = time-_prevTime;
		var i:Int, tweenCount:Int, delIndex:Int, delCount:Int;

		// Cleanup
		tweenCount = _tweens.length - 1;
		delCount = _tweensToDel.length;
		if( delCount!=0 ){
			for( i in 0...delCount ){
				delIndex = _tweensToDel[i]._index;
				_tweens[delIndex] = _tweens[tweenCount];
				_tweens[delIndex]._index = delIndex;
				tweenCount--;
			}
			_tweens.splice( tweenCount+1, delCount );
			_tweensToDel.splice( 0, delCount );
		}
		
		if ( tweenCount < 0 ) {
			#if (flash || nme || openfl)
			Lib.current.stage.removeEventListener (Event.ENTER_FRAME, onEnterFrame);
			#else
			_trigger.stop();
			_trigger.run = null;
			#end
		}
		else for( i in 0..._tweens.length ) _tweens[i].update( timeDelta );
		
		_prevTime = time;
	}
		
}