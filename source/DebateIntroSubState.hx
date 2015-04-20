package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;

/**
 * ...
 * @author Dave
 */
class DebateIntroSubState extends FlxSubState
{

	var p1:FlxSprite;
	var p2:FlxSprite;
	var name1:FlxText;
	var name2:FlxText;
	
	var vs:FlxSprite;
	
	
	
	var topic:FlxText;
	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		
	}
	
}