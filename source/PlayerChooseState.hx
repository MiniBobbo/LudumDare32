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

	public function new() {
		super();
		tb = new FlxSprite(0, 20, "assets/images/thoughtBubble.png");
		
		add(tb);
		
		t = new FlxText(0, 30, 800, "What should I say?", 25);
		t.setFormat(null, 25, FlxColor.BLACK, "center");
		add(t);
		
		options = new Vector<FlxButton>(4);
		for (i in 0...4) {
			var btn = new FlxButton();
			btn.makeGraphic(250, 40, FlxColor.TRANSPARENT, false);
			btn.label.setFormat(null, 25, FlxColor.BLACK, "center");
			options[i] = btn;
			add(options[i]);
		}
		
		options[0].setPosition(100, 80);
		options[1].setPosition(100,	130 );
		options[2].setPosition(400,80 );
		options[3].setPosition(400,130 );
		
		setRandomWords();
		/*
		 *	if (FlxG.mouse.justPressed) {
			var point = FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y);
			for (i in 0...4) {
				if (options[i].overlapsPoint(point)) {
					trace(options[i].text + " worth: " + currentRule.scoreWord(options[i].text));
				}
				
				options[i].text = getRandomWord();
				options[i].revive();
			}
			
			point.put();
		}
		 * 
		 * 
		 * */
		
	}
	
	override public function update():Void {
		if (FlxG.mouse.justPressed) {
			var point = FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y);
			for (i in 0...4) {
				if (options[i].overlapsPoint(point)) {
					Reg.word = options[i].text;
				}
			}
			point.put();
			this.close();
		}		
	}

	
	public function setRandomWords() {
		for(i in 0...4)
		options[i].text = Reg.getRandomWord();
	}
	
}