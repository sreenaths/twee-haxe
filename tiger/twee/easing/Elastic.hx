/**
 * Twee
 * @author Sreenath Somarajapuram
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */

package tiger.twee.easing;

import tiger.twee.interfaces.IEase;

class Elastic
{
	public static var easeIn:IEase = new EaseIn;
	public static var easeOut:IEase = new EaseOut;
	public static var easeInOut:IEase = new EaseInOut;
}

private class EaseIn implements IEase{
	
	private var _a:Float, _p:Float, _aTmp:Float, _pTmp:Float;
	
	function new( amplitude:Float=0, period:Float=0 ){ _a=_aTmp=amplitude, _p=_pTmp=period; }
	public function getExtendedInstance( amplitude:Float, period:Float=0 ):EaseIn{ return new EaseIn( amplitude, period ); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if (t == 0)
			return s;
		
		if ((t /= d) == 1)
			return s + c;
		
		_p = _pTmp, _a = _aTmp;
		
		if (!_p)
			_p = d * 0.3;
		
		var x:Float;
		if (!_a || _a < Math.abs(c))
		{
			_a = c;
			x = _p / 4;
		}
		else
		{
			x = _p / (2 * Math.PI) * Math.asin(c / _a);
		}
		
		return -(_a * Math.pow(2, 10 * (t -= 1)) *
			Math.sin((t * d - x) * (2 * Math.PI) / _p)) + s;
	}
}

private class EaseOut implements IEase{
	
	private var _a:Float, _p:Float, _aTmp:Float, _pTmp:Float;
	
	function new( amplitude:Float=0, period:Float=0 ){ _a=_aTmp=amplitude, _p=_pTmp=period; }
	public function getExtendedInstance( amplitude:Float, period:Float=0 ):EaseOut{ return new EaseOut( amplitude, period ); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if (t == 0)
			return s;
		
		if ((t /= d) == 1)
			return s + c;
		
		_p = _pTmp, _a = _aTmp;
		
		if (!_p)
			_p = d * 0.3;
		
		var x:Float;
		if (!_a || _a < Math.abs(c))
		{
			_a = c;
			x = _p / 4;
		}
		else
		{
			x = _p / (2 * Math.PI) * Math.asin(c / _a);
		}
		
		return _a * Math.pow(2, -10 * t) *
			Math.sin((t * d - x) * (2 * Math.PI) / _p) + c + s;
	}	
}

private class EaseInOut implements IEase{
	
	private var _a:Float, _p:Float, _aTmp:Float, _pTmp:Float;
	
	function new( amplitude:Float=0, period:Float=0 ){ _a=_aTmp=amplitude, _p=_pTmp=period; }
	public function getExtendedInstance( amplitude:Float, period:Float=0 ):EaseInOut{ return new EaseInOut( amplitude, period ); }
	
	public function compute( t:Float, s:Float, c:Float, d:Float ):Float{
		if (t == 0)
			return s;
		
		if ((t /= d / 2) == 2)
			return s + c;
		
		_p = _pTmp, _a = _aTmp;
		
		if (!_p)
			_p = d * (0.3 * 1.5);
		
		var x:Float;
		if (!_a || _a < Math.abs(c))
		{
			_a = c;
			x = _p / 4;
		}
		else
		{
			x = _p / (2 * Math.PI) * Math.asin(c / _a);
		}
		
		if (t < 1)
		{
			return -0.5 * (_a * Math.pow(2, 10 * (t -= 1)) *
				Math.sin((t * d - x) * (2 * Math.PI) /_p)) + s;
		}
		
		return _a * Math.pow(2, -10 * (t -= 1)) *
			Math.sin((t * d - x) * (2 * Math.PI) / _p ) * 0.5 + c + s;
	}
}
