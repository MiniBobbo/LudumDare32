package;

import flixel.util.FlxRandom;
import flixel.util.FlxSave;
import openfl.Assets;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var word:String = "";
	public static var words:Array<String>;

	private static function importWords():Void 
	{
		words = new Array<String>();
		var tempwords = Assets.getText("assets/data/words.txt");
		words = tempwords.split("\n");
	
	}
	
	public static function init() {
		importWords();
	}
	
	public static function getRandomWord():String {
		return words[FlxRandom.intRanged(0, words.length - 1)];
	}

}