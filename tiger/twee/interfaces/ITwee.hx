/**
 * Twee
 * @author Sreenath Somarajapuram
 */

package tiger.twee.interfaces;

interface ITwee {

//	function render( timeDelta:Int ):Void;

	/**
	 * Start the tween if the same is not running
	 * @return Boolean True if the tween was started successfully
	 */
	function start():Bool;

	/**
	 * Stop the tween if running
	 * @return Boolean True if the tween was stoped successfully
	 */
	function stop():Bool;

	/**
	 * Pass tween instances as arguments and the same will be started once the current tween ends. All the passed tween will be started in parallel. Chain this function call to chain tween.
	 * @return Boolean True if the tailing worked as expected
	 */
	function tail( tween:ITwee ):Bool;
	
	/**
	 * Destroy the current tween instance.
	 */
	function destroy():Void;

}