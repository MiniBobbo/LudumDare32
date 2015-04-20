package;

import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.ds.Vector;

/**
 * ...
 * @author Dave
 */
class ResultState extends FlxSubState
{

	var player:FlxSprite;
	var rule:FlxText;
	var mainResult:FlxText;
	var score:FlxText;
	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
	}
	
	override public function create():Void 
	{
		super.create();
		mainResult = new FlxText(100, 20, 600, "", 30);
		mainResult.setFormat(null, 30, FlxColor.WHITE, "center");
		mainResult.text = "Player " + Reg.winningPlayer + " wins!";
		add(mainResult);
		
		trace(Reg.debateRule.description);

	}
	
	override public function update():Void 
	{
		super.update();
	}
	
}