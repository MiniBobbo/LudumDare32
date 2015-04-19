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
class PlayerChooseState extends FlxSubState
{
	
	var options:Vector<FlxButton>;
	var tb:FlxSprite;
	var t:FlxText;
	var timer:FlxText;
	var countdown:Float;
	
	var blackBlock:FlxSprite;
	var records:Array<FlxText>;
	

	public function new() {
		super();
		tb = new FlxSprite(0, 20, "assets/images/thoughtBubble.png");
		
		countdown = Reg.PLAYER_CHOICE_TIME;
		timer = new FlxText(10, 30, 100, Std.int(countdown) + "", 30);
		timer.color = FlxColor.BLACK;
		add(tb);
		add(timer);
		t = new FlxText(0, 30, 800, "What should my next topic be?", 25);
		t.setFormat(null, 25, FlxColor.BLACK, "center");
		add(t);
		
		options = new Vector<FlxButton>(4);
		for (i in 0...4) {
			var btn = new FlxButton();
			btn.makeGraphic(300, 40, FlxColor.TRANSPARENT, false);
			btn.label.setFormat(null, 25, FlxColor.BLACK, "center");
			options[i] = btn;
			add(options[i]);
		}
		
		options[0].setPosition(50, 80);
		options[1].setPosition(50,	130 );
		options[2].setPosition(400,80 );
		options[3].setPosition(400,130 );
		
		setRandomWords();
		
		//Draw the records of the past guesses to help the player.
		blackBlock = new FlxSprite(20, 300);
		blackBlock.makeGraphic(760, 290, FlxColor.BLACK);
		blackBlock.alpha = .7;
		add(blackBlock);
		
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
		var point = FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y);

		for (o in options) {
			if (o.overlapsPoint(point))
				o.label.color = FlxColor.RED;
				else
				o.label.color = FlxColor.BLACK;
		}
		if (FlxG.mouse.justPressed) {
			for (i in 0...4) {
				if (options[i].overlapsPoint(point)) {
					Reg.word = options[i].text;
				}
			}
			point.put();
			this.close();
		}
		
		countdown -= FlxG.elapsed;
		if (countdown <= 0) {
		Reg.word = null;
		this.close();
		} else {
			timer.text = Std.int(countdown + 1) + "";
			if (countdown <= 3)
			timer.color = FlxColor.RED;
		}
	}

	
	public function setRandomWords() {
		for(i in 0...4)
		options[i].text = Reg.getRandomWord();
	}
	
}