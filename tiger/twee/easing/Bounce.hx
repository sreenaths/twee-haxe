/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Bounce{
	public static var easeIn:IEase = new EaseIn();
	public static var easeOut:IEase = new EaseOut();
	public static var easeInOut:IEase = new EaseInOut();
}

private class EaseIn implements IEase{
	private var easeOut:IEase = new EaseOut();
	
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c - easeOut.compute(d - t, 0, c, d) + s;
	}
}

private class EaseOut implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if ((t /= d) < (1 / 2.75))
			return c * (7.5625 * t * t) + s;
			
		else if (t < (2 / 2.75))
			return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + s;
			
		else if (t < (2.5 / 2.75))
			return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + s;
			
		else
			return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + s;
	}	
}

private class EaseInOut implements IEase{
	private var easeIn:IEase = new EaseIn(); // TODO:Convert to internal functions
	private var easeOut:IEase = new EaseOut();
	
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if (t < d/2)
			return easeIn.compute(t * 2, 0, c, d) * 0.5 + s;
		else
			return easeOut.compute(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + s;
	}
}
