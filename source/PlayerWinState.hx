package;

import flixel.FlxSubState;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxPoint;

import haxe.ds.Vector;

/**
 * ...
 * @author Dave
 */
class PlayerWinState extends FlxSubState
{
	
	
	var startDebate:FlxButton;
	var t:FlxText;
	var debateRule:FlxText;
	
	var blackBlock:FlxSprite;
	var records:Array<FlxText>;
	

	public function new() {
		super();
		t = new FlxText(0, 30, 800, "", 25);
		t.setFormat(null, 30, FlxColor.WHITE, "center");

		
		if (Reg.scores[0] > Reg.scores [1] ) {
			t.text = Reg.names[0] + " wins!";
		} else if (Reg.scores[0] < Reg.scores[1] ) {
			t.text = Reg.names[1] + " wins!";
		} else {
			t.text = "Draw!";
		}

		
		add(t);

		debateRule = new FlxText(100, 130, 600, "Scoring: " + Reg.debateRule.description, 25);
		debateRule.setFormat(null, 30, FlxColor.WHITE, "center");
		
		add(debateRule);
		
		//Draw the records of the past guesses to help the player.
		blackBlock = new FlxSprite(20, 300);
		blackBlock.makeGraphic(760, 290, FlxColor.BLACK);
		blackBlock.alpha = .7;
		add(blackBlock);

		startDebate = new FlxButton(300, 400, "Back to\nmenu", menu);
		startDebate.makeGraphic(200, 200, FlxColor.TRANSPARENT);
		startDebate.label.setFormat(null, 30, FlxColor.WHITE, "center");
		add(startDebate);
		
		
		var p1y:Float = 310;
		var p2y:Float = 310;
		
		var spacing:Float = 30;
		
		for (r in Reg.records) {
			if (r.player == 0) {
				var t:FlxText = new FlxText( 30, p1y, 380, r.word.substr(0, r.word.length - 1) + " " + r.score, 15);
				t.setFormat(null, 15, FlxColor.WHITE, "center");
				add(t);
				p1y += spacing;
			} else {
				var t:FlxText = new FlxText( 400, p2y, 380, r.word.substr(0, r.word.length - 1) + " " + r.score, 15);
				t.setFormat(null, 15, FlxColor.WHITE, "center");
				add(t);
				p2y += spacing;
			}
		}
		
	}
	
	override public function update():Void {
		super.update();

	}
	
	public function menu() {
		FlxG.switchState(new MenuState());
	}
	
}