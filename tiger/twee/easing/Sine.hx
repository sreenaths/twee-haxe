/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Sine
{
	public static var easeIn:IEase = new EaseIn();
	public static var easeOut:IEase = new EaseOut();
	public static var easeInOut:IEase = new EaseInOut();
}

private class EaseIn implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + s;
	}
}

private class EaseOut implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * Math.sin(t / d * (Math.PI / 2)) + s;
	}	
}

private class EaseInOut implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + s;
	}
}
