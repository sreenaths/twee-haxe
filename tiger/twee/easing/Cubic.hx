/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Cubic
{
	public static var easeIn:IEase = new EaseIn();
	public static var easeOut:IEase = new EaseOut();
	public static var easeInOut:IEase = new EaseInOut();
}

private class EaseIn implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * (t /= d) * t * t + s;
	}
}

private class EaseOut implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * ((t = t / d - 1) * t * t + 1) + s;
	}	
}

private class EaseInOut implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if ((t /= d / 2) < 1)
			return c / 2 * t * t * t + s;
		return c / 2 * ((t -= 2) * t * t + 2) + s;
	}
}
