package;

import ai.AI;
import flixel.util.FlxRandom;
import flixel.util.FlxSave;
import haxe.ds.Vector;
import openfl.Assets;
import rules.Rule;
import rules.RuleConsonants;
import rules.RuleDoubleLetters;
import rules.RuleHighestLetter;
import rules.RuleLetterCount;
import rules.RulePercentVowles;
import rules.RuleSmallWords;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var word:String = "";
	public static var words:Array<String>;
	public static var arguments:Array<String>;
	public static var rebuttals:Array<String>;
	public static var playerAvatar:Vector<String>;
	public static var topic:String;
	
	public static var rules:Array<Rule>;

	public static var debateRule:Rule;
	
	
	//Game finished variables.
	public static var records:Array<Record>;
	public static var scores:Vector<Int>;
	
	
	public static var names:Vector<String>;
	public static var compControlled:Vector<Bool>;
	public static var compAI:Vector<AI>;
	
	public static var avatarList:Array<String> = ["einstein", "neildegrassetyson", "hal9000", "Aristotle"];
	
	public static var DEBATE_LENGTH:Int = 10;
	
	public static var winningPlayer:Int = -1;
	
	//Howw long does the player have to decide on a word?
	public static var PLAYER_CHOICE_TIME = 10;
	
	//How long of a delay between letters typed?  Smaller = faster.
	public static var TYPE_DELAY = .00001;
	
	//How long should the transitions stay on the screen?
	public static var TRANS_TIME = 2;
	
	//How long should the speech bubble stay on te screen after the typing is completed?
	public static var SPEECH_TIME = 3.5;

	private static function importWords():Void 
	{
		//var tempwords = Assets.getText("assets/data/words.txt");
		words = Assets.getText("assets/data/nouns/nouns.txt").split("\n");
		arguments = Assets.getText("assets/data/nouns/arguments.txt").split("\n");
		rebuttals = Assets.getText("assets/data/nouns/rebuttals.txt").split("\n");
		
	}
	
	private static function importRules() {
		rules = new Array<Rule>();
		rules.push(new RuleConsonants());
		rules.push(new RuleDoubleLetters());
		rules.push(new RuleHighestLetter());
		rules.push(new RuleLetterCount());
		rules.push(new RulePercentVowles());
		rules.push(new RuleSmallWords());
	}
	
	public static function getRandomRule():Rule {
		return rules[FlxRandom.intRanged(0, rules.length - 1) ];
	}


	
	public static function init() {
		importWords();
		importRules();
		topic = getRandomWord();
		names = new Vector<String>(2);
		names[0] = "Player 1";
		names[1] = "Player 2";
		
		scores = new Vector<Int>(2);
		scores[0] = 0;
		scores[1] = 0;
		
		records = new Array<Record>();
		
		playerAvatar = new Vector<String>(2);
		playerAvatar[0] = "hal9000";
		playerAvatar[1] = "neildegrassetyson";
		
		compControlled = new Vector<Bool>(2);
		compControlled[0] = false;
		compControlled[1] = true;
		
		compAI = new Vector<AI>(2);
		compAI[0] = new AI();
		compAI[1] = new AI();
		

	}
	
	public static function setWinner(winner:Int) {
		winningPlayer = winner;
	}
	
	public static function getRandomWord():String {
		return words[FlxRandom.intRanged(0, words.length - 1)];
	}
	
	public static function getRandomArgument():String {
		return arguments[FlxRandom.intRanged(0, arguments.length - 1)];
	}
	
	public static function getRandomRebuttal():String {
		return rebuttals[FlxRandom.intRanged(0, rebuttals.length - 1)];
	}
	
	/**
	 * Sets the rule for this debate in the Reg object.  This isn't important for the playstate, but might be useful for the end display or soemthing.
	 * @param	r
	 */
	public static function setRule(r:Rule) {
		debateRule = r;
	}
	
	public static function addRecord(player:Int, ?rWord:String, rScore:Int ) {
		var r = new Record();
		r.player = player;
		if (rWord == null)
		r.word = "";
		else
		r.word = rWord;
		r.score = rScore;
		records.push(r);
	}

}