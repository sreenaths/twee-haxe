/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Back
{
	public static var easeIn:IEase = new EaseIn();
	public static var easeOut:IEase = new EaseOut();
	public static var easeInOut:IEase = new EaseInOut();
}

private class EaseIn implements IEase{
	
	private var _overShoot:Float;
	
	public function new( overShoot:Float=1.70158 ){ _overShoot=overShoot; }
	public function getExtendedInstance( overShoot:Float ):EaseIn{ return new EaseIn(overShoot); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * (t /= d) * t * ((_overShoot + 1) * t - _overShoot) + s;
	}
	
}

private class EaseOut implements IEase{
	
	private var _overShoot:Float;
	
	public function new( overShoot:Float=1.70158 ){ _overShoot=overShoot; }
	public function getExtendedInstance( overShoot:Float ):EaseOut{ return new EaseOut(overShoot); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * ((t = t / d - 1) * t * ((_overShoot + 1) * t + _overShoot) + 1) + s;
	}
	
}

private class EaseInOut implements IEase{
	
	private var _overShoot:Float;
	private var _overShootTmp:Float;
	
	public function new( overShoot:Float=1.70158 ){ _overShoot=overShoot; }
	public function getExtendedInstance( overShoot:Float ):EaseInOut{ return new EaseInOut(overShoot); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		_overShootTmp = _overShoot;
		if ((t /= d / 2) < 1)
			return c / 2 * (t * t * (((_overShootTmp *= (1.525)) + 1) * t - _overShootTmp)) + s;
		return c / 2 * ((t -= 2) * t * (((_overShootTmp *= (1.525)) + 1) * t + _overShootTmp) + 2) + s;
	}
}
