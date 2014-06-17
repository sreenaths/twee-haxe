/**
 * Twee
 * @author Sreenath Somarajapuram
 */

package tiger.twee;
import tiger.twee.interfaces.ITwee;

class Twee{	

	public static function to( target:Dynamic, duration:Float, vars:Dynamic, options:Dynamic = null ):ITwee {
		return tweenfactory( target, duration, null, vars, options );
	}

	public static function from( target:Dynamic, duration:Float, vars:Dynamic, options:Dynamic = null ):ITwee {
		return tweenfactory( target, duration, vars, null, options );
	}

	public static function fromTo( target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic, options:Dynamic = null ):ITwee {
		return tweenfactory( target, duration, fromVars, toVars, options );
	}
	
	public static function delayedCall( duration:Float, callback:Dynamic, params:Array<Dynamic>=null ):ITwee{
		if ( Reflect.isFunction( callback ) ) return new Tween( {}, duration, null, null, { onComplete:callback, onCompleteparams:params } );
		else throw( "Callback must be a function!" );
	}	

	public static function killTweensOf( target:Dynamic, complete:Bool=false ):Void{
		Tween.killTweensOf( target, complete );
	}
	
	private static inline function tweenfactory( target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic, options:Dynamic ):ITwee {
		if ( options != null && Reflect.hasField(options, "onUpdate") ) {
			return new TweenWithUpdate( target, duration, fromVars, toVars, options );
		}
		return new Tween( target, duration, fromVars, toVars, options );
	}
	
}