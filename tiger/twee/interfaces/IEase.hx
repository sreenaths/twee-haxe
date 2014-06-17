/**
 * Twee
 * @author Sreenath Somarajapuram
 */

package tiger.twee.interfaces;

interface IEase
{
	/**
	 *  @param t Time from start ( Same unit as d ).
	 *
	 *  @param s Specifies the starting value.
	 *
	 *  @param c Specifies the total change in value.
	 *
	 *  @param d Specifies the duration of the effect ( Same unit as t ).
	 *
	 *  @return Number Value @ timeElapsed.
	 */  
	function compute( t:Float, s:Float, c:Float, d:Float ):Float;
}