package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
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
import PlayerChooseState;
import Record;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	//History variables
	var records:Array<Record>;

	var playerChooseState:FlxSubState;
	
	//Game variables
	var gs:GameState;
	var lastgs:GameState;
	var score:Vector<Int>;
	var rules:Array<Rule>;
	
	var activeDebator:Int = 0;
	
	var currentRule:Rule;
	
	//Display variables
	var mainText:FlxTypeText;
	var roundsComplete:FlxText;
	var names:FlxTypedGroup<FlxText>;
	var damageDealt:FlxTypedGroup<FlxText>;
	var speechBubble:FlxSprite;
	
	var transition:Int = 0;
	
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.init();
		playerChooseState = new PlayerChooseState();
		
		rules = new Array<Rule>();
		importRules();
		
		//Set the current rule.
		currentRule = getRandomRule();
		
		setupDisplay();	
		
		
		//Test stuff
		var layout = new FlxSprite(0, 0, "assets/images/layoutTest.png");
		add(layout);
		gs = GameState.debatestart;

		//Add things to the stage.
		
		
		add(speechBubble);

		
		var p1 = new FlxSprite(80, 250);
		p1.loadGraphic("assets/images/einstein.png", true);
		p1.animation.add("stand", [2]);
		p1.animation.add("talk", [2,3,4,5], 10);
		p1.animation.play("stand");
		add(p1);
		var p2 = new FlxSprite(550, 250);
		p2.loadGraphic("assets/images/einstein.png", true);
		p2.animation.add("stand", [2]);
		p2.animation.add("talk", [2,3,4,5], 10);
		p2.animation.play("talk");
		p2.flipX = true;
		add(p2);
		
		
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
		
		switch (gs) 
		{
			case GameState.transition:
				if (transition == 0) {
					//Go to the next state based on where we came from.
				}
				
			case GameState.firstDebate:
				if (activeDebator == 1) {
					
				}
				
			case GameState.score:
				trace(Reg.word + " scored " + currentRule.scoreWord(Reg.word));
				lastgs = gs;
				gs = GameState.transition;
			default:
				
		}
		
		if (FlxG.keys.anyJustPressed(["SPACE"] )) {
			var ss = new PlayerChooseState();
			lastgs = gs;
			gs = GameState.score;
			this.openSubState(ss);
		}

		
	}
	
	public function importRules() {
		rules.push(new RuleLetterCount());
	}
	
	public function getRandomRule():Rule {
		return rules[FlxRandom.intRanged(0, rules.length - 1) ];
	}
	
	

	
	function setupDisplay():Void 
	{
		speechBubble = new FlxSprite(0, 20, "assets/images/speechBubble.png");
		speechBubble.flipX = false;
		speechBubble.kill();
		
		
	}
}