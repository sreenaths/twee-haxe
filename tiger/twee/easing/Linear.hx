/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Linear{
	public static var easeNone:IEase = new LinearEase();
	public static var easeIn:IEase = easeNone;
	public static var easeOut:IEase = easeNone;
	public static var easeInOut:IEase = easeNone;
}

private class LinearEase implements IEase{
	public function new(){}
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		return c * t / d + s;
	}
}


