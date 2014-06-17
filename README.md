#Twee 1.0

Twee is a cross platform, cross language tween animation library.

This repo was created specifically for HaXe programming language. Follow my git account for notifications on updates, and releases in other languages.

##Instal Twee
Tween is not yet part if haxelib, and hence cannot be installed directly. Follow either of the following to add the same to your local references.

###Without GIT in your system :	
Go to https://github.com/sreenaths/twee-haxe and download the project as a Zip.
Now on command line, go to the folder with the zip and type the following.

	haxelib local <zip-name>

###With GIT:
	git clone https://github.com/sreenaths/twee-haxe
	haxelib dev twee twee-haxe

To add Twee to a standard Haxe project, use `-lib twee` in your HXML

To include Twee in an OpenFL project, add `<haxelib name="twee" />` to your project.xml.

##Usage
Tween is as simple as it can be. https://github.com/sreenaths/twee-haxe-sample demonstrates an OpenFl sample implementation.

####You can tween anything in HaXe using Twee. The tweening function expects four types of parameters.

target: This is the instance of which the properties would be changes. It can be of any type

duration: Duration for which the animation would be performed. The value is expected in seconds.

vars: A key value hash, where keys are the properties to be changed.

options: A key value pair of options to tweak the tween.


####Following are the three tweening functions:
###to:
	//Twee.to( target:Dynamic, duration:Float, vars:Dynamic, options:Dynamic = null ):ITwee;
	Twee.to( target, 1, { x:1 }, { repeat: 5 } );

Creates a tween from the current target values to the specified var parameters and returns the instance.

###from:
	//Twee.from( target:Dynamic, duration:Float, vars:Dynamic, options:Dynamic = null ):ITwee;
	Twee.from( target, 1, { x:-1 }, { repeat: 5 } );

Creates a tween from the specified var parameters to the current target values and returns the instance.

###fromTo:
	//Twee.fromTo( target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic, options:Dynamic = null ):ITwee;
	Twee.fromTo( target, 1, { x:-1 }, { x: 1 }, { repeat: 5 } );

Creates a tween from the specified var parameters to the specified var parameters and returns the instance.

##Twee Options

Twee provides an ever growing list of options, to tweak tween the way you want. All the options are passed as part of the options argument on the tweening functions.

	Twee.to( target, duration, vars, {
		optionName1: value,
		optionName2: value,
		...
		optionNameN: value
	} );

Following is a list of the supported options.

###easing:
Default: Quadratic.easeOut, Type: IEase

The passed function will be applied for tweening all properties passed in vars. Value can be either of easeIn, easeOut or easeInOut properties of any of the 11 easing classes. Available easing classes are Back, Bounce, Circular, Cubic, Elastic, Exponential, Linear, Quadratic, Quartic, Quintic and Sine.

###repeat:
Default: 1, Type: Int

Animation would be repeated the given number of times. If the value is less or equal to 0, the animation will continue indefinitely.

###inactive:
Default: false, Type: Bool

If true, the animation won't start automatically. start function would have to be called for the same to commence.

###onUpdate:
Type: Function

The function will be called after each update call. Use onUpdateParams to pass arguments on calling the function.

###onUpdateParams:
Type: Array

An array of parameters that would be passed as arguments to the onUpdate function handler.

###onComplete:
Type: Function

If a function is passed, the same will be called on completion of the animation. If repeat is set, the same would be called only after all iterations. Use onCompleteParams to pass arguments on calling the function.

###onCompleteParams:
Type: Array

An array of parameters that would be passed as arguments to the onComplete function handler.

###tonfro:
Default: false, Type: Bool

If set, the to and from values will be swapped on repeating the animation.

##Twee Member Methods
Member methods provided by Twee can be used to control a tween instance. The comes a part of the ITween interface.

###start:
Signature: start():Bool

Tries to starts an idle tween animation and returns true if the same was successful.

###destroy:
Signature: destroy():Bool

Destroy the tween instance.

###tail:
Signature: tail( tween:ITwee ):Bool

Tail expects an ITwee instance as the argument. The passed tween will be automatically started after the completion of the current tween. Ensure that the inactive argument is set to true while instantiating the tailing tween.


##Static Twee Methods
Twee provides a set of static methods to control multiple tweens.

###killTweensOf
Signature: killTweensOf( target:Dynamic, complete:Bool=false ):Bool

Kill all tweens attached to the respective target. If complete is passed true, the onComplete function of each tween will be called before destroying the instance.

###delayedCall
Signature: delayedCall( duration:Float, callback:Function, params:Array<Dynamic>=null ):Bool

If a function must be called after a specific duration. After duration time, callback function will be called with the passed arguments.

