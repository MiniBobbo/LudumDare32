package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import haxe.ds.Vector;

/**
 * ...
 * @author Dave
 */
class ResultState extends FlxSubState
{

	var players:Vector<FlxSprite>;
	var rule:FlxText;
	var results:Vector<Array<String>>;
	
	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		
	}
	
}