package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class FinalResultState extends FlxState
{

	var player:FlxSprite;
	var rule:FlxText;
	var mainResult:FlxText;
	var score:FlxText;

	override public function create():Void 
	{
		super.create();
		
		mainResult = new FlxText(100, 20, 600, "", 30);
		mainResult.setFormat(null, 30, FlxColor.WHITE, "center");
		mainResult.text = "Player " + Reg.winningPlayer + " wins!";
		add(mainResult);
		
		trace(Reg.debateRule.description);

	}	
}