package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import haxe.ds.Vector;
import openfl.Assets;
import rules.Rule;
import rules.RuleLetterCount;
import source.Record;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	//History variables
	var records:Array<Record>;
	
	
	//Game variables
	var words:Array<String>;
	var score:Vector<Int>;
	var rules:Array<Rule>;
	
	var currentRule:Rule;
	
	//Display variables
	var mainText:FlxTypeText;
	var roundsComplete:FlxText;
	var names:FlxTypedGroup<FlxText>;
	var damageDealt:FlxTypedGroup<FlxText>;
	
	var options:Vector<FlxButton>;
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		words = new Array<String>();
		var tempwords = Assets.getText("assets/data/words.txt");
		words = tempwords.split("\n");

		//Game variables
		rules = new Array<Rule>();
		importRules();
		
		//Get the current rule.
		currentRule = getRandomRule();
		//Display variables
		options = new Vector<FlxButton>(4);
		for (i in 0...4) {
			var btn = new FlxButton();
			btn.makeGraphic(250, 50, FlxColor.TRANSPARENT, false);
			btn.label.setFormat(null, 15, FlxColor.WHITE, "center");
			btn.kill();
			options[i] = btn;
		}
		
		options[0].setPosition(150, 100);
		options[1].setPosition(150, 200);
		options[2].setPosition(400, 100);
		options[3].setPosition(400, 200);
		
		for(i in 0...4)
		add(options[i]);
		
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (FlxG.mouse.justPressed) {
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
	}
	
	public function importRules() {
		rules.push(new RuleLetterCount());
	}
	
	public function getRandomRule():Rule {
		return rules[FlxRandom.intRanged(0, rules.length - 1) ];
	}
	
	private function getRandomWord():String {
		return words[FlxRandom.intRanged(0, words.length - 1)];
	}
}