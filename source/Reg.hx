package;

import ai.AI;
import flixel.util.FlxRandom;
import flixel.util.FlxSave;
import haxe.ds.Vector;
import openfl.Assets;

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
	
	public static var records:Array<Record>;
	
	public static var names:Vector<String>;
	public static var compControlled:Vector<Bool>;
	public static var compAI:Vector<AI>;
	
	public static var DEBATE_LENGTH:Int = 10;
	
	//Howw long does the player have to decide on a word?
	public static var PLAYER_CHOICE_TIME = 10;
	
	//How long should the transitions stay on the screen?
	public static var TRANS_TIME = 1.5;
	
	//How long should the speech bubble stay on te screen after the typing is completed?
	public static var SPEECH_TIME = 1;

	private static function importWords():Void 
	{
		var tempwords = Assets.getText("assets/data/words.txt");
		words = tempwords.split("\n");
		arguments = Assets.getText("assets/data/arguments.txt").split("\n");
		rebuttals = Assets.getText("assets/data/rebuttals.txt").split("\n");
		
	}
	
	public static function init() {
		importWords();
		topic = getRandomWord();
		names = new Vector<String>(2);
		names[0] = "Player 1";
		names[1] = "Player 2";
		
		records = new Array<Record>();
		
		playerAvatar = new Vector<String>(2);
		playerAvatar[0] = "einstein";
		playerAvatar[1] = "neildegrassetyson";
		
		compControlled = new Vector<Bool>(2);
		compControlled[0] = false;
		compControlled[1] = true;
		
		compAI = new Vector<AI>(2);
		compAI[0] = new AI();
		compAI[1] = new AI();
		

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