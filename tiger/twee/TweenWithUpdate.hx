/**
 * Twee
 * @author Sreenath Somarajapuram
 */

package tiger.twee;

class TweenWithUpdate extends Tween{

	public function new( target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic, options:Dynamic ){
		super(  target, duration, fromVars, toVars, options );
	}
	
	override private function update( timeDelta:Int ):Void{
		if( _timeElapsed==_duration ){ // So that the callback is called in next frame.
			complete();
		}
		else{
			_timeElapsed += timeDelta;
			if( _timeElapsed>_duration ) _timeElapsed=_duration;

			updatePropertiesWithUpdateCall();
		}
	}
	
	private inline function updatePropertiesWithUpdateCall():Void {
		updateProperties();
		_options.onUpdate.apply( null, _options.onUpdateParams );
	}
		
}