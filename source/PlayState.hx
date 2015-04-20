package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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
	var nextgs:GameState;
	var score:Vector<Int>;
	
	var currentRound:Int = 0;
	var displayQueue:Array<String>;
	
	var activeSpeaker:Int = 0;
	
	var currentRule:Rule;
	
	//Display variables
	var bg:FlxSprite;
	var mainText:FlxTypeText;
	var roundsComplete:FlxText;
	var damageDealt:FlxTypedGroup<FlxText>;
	var speechBubble:FlxSprite;
	
	var players:Vector<FlxSprite>;
	
	var crowd:FlxSprite;
	
	var scoreText:Vector<FlxText>;
	
	var mod:FlxSprite;
	
	var displayText:FlxText;
	var transitions:Int = 0;
	var transitionTime:Float;
	
	var btnMute:FlxButton;
	
	//Debug stuff
	var debugtext:FlxText;
	
	//Music
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		//Reg.init();
		score = new Vector<Int>(2);
		score[0] = 0; 
		score[1] = 0;
		
		players = new Vector<FlxSprite>(2);
		
		//Set the current rule.
		currentRule = Reg.getRandomRule();
		Reg.debateRule = currentRule;
		setupDisplay();	
		
		
		//Test stuff
		gs = GameState.debatestart;

		//Add things to the stage.
		
		add(bg);
		add(mod);
		for (s in scoreText)
		add(s);
		
		for (p in players)
		add(p);
		
		add(displayText);
		
		add(speechBubble);
		add(mainText);
		
		add(crowd);

		//Start the music
		#if flash
		FlxG.sound.playMusic("assets/music/main.mp3", .4, true);
		#else
		FlxG.sound.playMusic("assets/music/main.wav", .4, true);
		#end
		debugtext = new FlxText(10, 550, 780, "", 10);
		//add(debugtext);
		
		btnMute =  new FlxButton(10, 570, "Mute", muteMusic);
		btnMute.makeGraphic(150, 30, FlxColor.TRANSPARENT);
		btnMute.label.setFormat(null, 20, FlxColor.WHITE, "center");
		add(btnMute);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
	
	public function muteMusic() {
		if (btnMute.text == "Mute") {
			btnMute.text = "Unmute";
			FlxG.sound.muted = true;
		} else {
			btnMute.text = "Mute";
			FlxG.sound.muted = false;
			
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		debugtext.text = gs +"";
		
		switch (gs) 
		{
			case GameState.debatestart:
				mod.animation.play("center");
				addToQueue("Start of Debate");
				nextgs = GameState.roundstart;
				gs = GameState.transition;
				
				
			case GameState.playerselect:
				if (Reg.compControlled[activeSpeaker]) {
					var words = new Array<String>();
					for(i in 0...4)
					words.push(Reg.getRandomWord());
					Reg.word = words[Reg.compAI[activeSpeaker].pickWord(words, currentRule)];
				} else {
					var ss = new PlayerChooseState();
					this.openSubState(ss);
				}
				//Set the transition time to -1 so the next state knows it is the first time it is running.
				transitionTime = -1;
				//This transitions to the speech bubblse.
				gs = GameState.writetext;
				
			case GameState.roundstart:	
				currentRound++;
				//If this is an odd numbered round, player 1 starts.
				addToQueue("Start of Round " + currentRound);
				nextgs = GameState.firstDebate;
				gs = GameState.transition;
					
				
			case GameState.roundend:
				mod.animation.play("center");
				addToQueue("END OF ROUND " + currentRound);
				if (currentRound == Reg.DEBATE_LENGTH) 
					nextgs = GameState.debateEnd;
				else
				nextgs = GameState.roundstart;
				gs = GameState.transition;
			
			case GameState.transition:
					transitionTime -= FlxG.elapsed;
					if (transitionTime <= 0) {
					finishTransition();
						if (displayQueue.length == 0)
						gs = nextgs;
					}
				
				
			case GameState.firstDebate:
				//If this is an odd numbered round, player 1 makes the statement.
				if (currentRound % 2 == 1) {
					activeSpeaker = 0;
					mod.animation.play("left");
					addToQueue(Reg.names[0] + ", opening statement.");
				}
				else {
					activeSpeaker = 1;
					mod.animation.play("right");
					addToQueue(Reg.names[1] + ", opening statement.");
				
				}
				gs = GameState.transition;
				nextgs = GameState.playerselect;
			case GameState.secondDebate: 
				//If this is an odd numbered round, player 2 makes the rebuttal.
				if (currentRound % 2 == 1) {
					activeSpeaker = 1;
					mod.animation.play("right");
					addToQueue(Reg.names[1] + ", your rebuttal.");
				}
				else {
					activeSpeaker = 0;
					mod.animation.play("left");
					addToQueue(Reg.names[0] + ", your rebuttal.");
				}
				gs = GameState.transition;
				nextgs = GameState.playerselect;
				
			case GameState.score:
				var thisScore:Int = 0;
				if(Reg.word != null) 
				thisScore = currentRule.scoreWord(Reg.word.substr(0, Reg.word.length-1));
				
				Reg.addRecord(activeSpeaker, Reg.word, thisScore);
				
				addToQueue(Reg.names[activeSpeaker] + " scored " + thisScore + " points.");
				score[activeSpeaker] += thisScore;
				scoreText[activeSpeaker].text = score[activeSpeaker] + "";
				
				gs = GameState.transition;
				
				//Figure out if we need to go to the second Speaker or if we are done with the round.
				if ((currentRound % 2 == 1 && activeSpeaker == 0) || (currentRound % 2 == 0 && activeSpeaker == 1))
				nextgs = GameState.secondDebate;
				else
				nextgs = GameState.roundend;
				
			case GameState.writetext:
				//If the transition time is -1, this is the first time we going here.
				if (transitionTime == -1) {
					if (Reg.word == null) {
					startTyping("I... err.... ummm... well... ");
						
					} else 
					generateStatement();
				}
				transitionTime -= FlxG.elapsed;
				if (transitionTime <= 0) {
					speechBubble.kill();
					mainText.kill();
					gs = GameState.score;
				}
				
				
				
				case GameState.debateEnd:
					addToQueue("Debate over");
					Reg.scores[0] = score[0];
					Reg.scores[1] = score[1];
					nextgs = GameState.showresults;
					gs = GameState.transition;
					
				case GameState.showresults:
					//FlxG.camera.fade(FlxColor.BLACK, 1, false, function() { FlxG.switchState(new FinalResultState()); } );
					//FlxG.camera.fade(FlxColor.BLACK, 1, false, function() { var ss = new PlayerWinState();
					this.openSubState(new PlayerWinState());
					//});
				default:
				
		}
		
		if (FlxG.keys.anyJustPressed(["SPACE"] )) {
			var ss = new PlayerChooseState();
			nextgs = gs;
			gs = GameState.score;
			this.openSubState(ss);
		}

		
	}

	private function makeStatement() {
		startTyping("I am choosing the word " + Reg.word);

	}
	
	private function generateStatement() {
		var rebuttal:Bool = false;
		if (currentRound % 2 == activeSpeaker) 
			rebuttal = true;
		
		var sArray:Array<String>;
		if (rebuttal)
			sArray = Reg.getRandomRebuttal().split("*");
		else
			sArray = Reg.getRandomArgument().split("*");
	
		mainText.clearFormats();
		var toSend:String = "";
		var letterCount = 0;
			
		for (i in 0...sArray.length) {
			var s = sArray[i];
			toSend += s;
			letterCount += s.length;
			if (i != sArray.length - 1) {
				toSend += Reg.word.substr(0, Reg.word.length - 1);
				mainText.addFormat(new FlxTextFormat(FlxColor.CORAL, false, true, null, letterCount, letterCount + Reg.word.length-1));
				letterCount += Reg.word.length -1;
			}
		}
		startTyping(toSend);
	}

	
	
	
	
	private function addToScore(player:Int, score:Int) {
		
	}
	
	private function addToQueue(s:String) {
		displayQueue.push(s);
		if (displayQueue.length == 1)
		startTransition();
	}
	
	private function startTransition() {
		transitionTime = Reg.TRANS_TIME;
		displayText.text = displayQueue.shift();
		displayText.set_visible(true);
		displayText.centerOrigin();
		displayText.scale.set(.01, .01);
		
		FlxTween.tween(displayText.scale, { x:1, y:1 }, .5, {ease:FlxEase.sineInOut} );
		
	}
	
	public function finishTransition() {
		if (displayQueue.length > 0) {
			startTransition();
		} else
		displayText.set_visible(false);
	}
	
	public function startTyping(s:String) {
		//Set the transition delay to something super high/
		transitionTime = 10000;
		
		//Revive the speech bubble
		speechBubble.revive();
		
		//Flip it for the right player.
		if (activeSpeaker == 0)
		speechBubble.flipX = false;
		else
		speechBubble.flipX = true;
		
		//Start typing.
		mainText.revive();
		mainText.resetText(s);
		//mainText.addFormat(new FlxTextFormat(FlxColor.RED, true,null,null, 5, 6));
		mainText.start(Reg.TYPE_DELAY, true, false, null, null, finishTyping);
		
		players[activeSpeaker].animation.play("talk");
	}
	
	public function finishTyping() {
		players[activeSpeaker].animation.play("stand");
		transitionTime = Reg.SPEECH_TIME;
		
	}
	
	function setupDisplay():Void 
	{
		displayQueue = new Array<String>();
		
		displayText = new FlxText(50, 30, 700, "", 50);
		displayText.setFormat(null, 50, FlxColor.WHITE, "center");
		
		speechBubble = new FlxSprite(0, 20, "assets/images/speechBubble.png");
		speechBubble.flipX = false;
		speechBubble.kill();
		
		crowd = new FlxSprite(0, 500, "assets/images/crowd.png");
		
		mainText = new FlxTypeText(50, 50, 700, "", 20);
		mainText.setFormat(null, 20, FlxColor.BLACK, "center");
		
		scoreText = new Vector<FlxText>(2);
		scoreText[0] = new FlxText(290, 310, 125, score[0] + "", 15);
		scoreText[0].setFormat(null, 25, FlxColor.WHITE, "center");
		scoreText[1] = new FlxText(395, 310, 125, score[1] + "", 15);
		scoreText[1].setFormat(null, 25, FlxColor.WHITE, "center");
		
		
		
		bg = new FlxSprite(0, 0, "assets/images/bg.png");
		mod = new FlxSprite(280, 210);
		mod.loadGraphic("assets/images/mod.png", true, 250);
		mod.animation.add("center", [0]);
		mod.animation.add("right", [1]);
		mod.animation.add("left", [2]);
		
		players[0] = new FlxSprite(80, 250);
		players[0] .loadGraphic("assets/images/" + Reg.playerAvatar[0]+ ".png", true);
		players[0] .animation.add("stand", [0]);
		players[0] .animation.add("talk", [0,1,2,3], 10);
		players[0] .animation.play("stand");
		players[1]  = new FlxSprite(550, 250);
		players[1] .loadGraphic("assets/images/" + Reg.playerAvatar[1]+ ".png", true);
		players[1].animation.add("stand", [0]);
		players[1].animation.add("talk", [0,1,2,3], 10);
		players[1].animation.play("stand");
		players[1].flipX = true;

		
	}
}