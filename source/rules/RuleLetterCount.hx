package rules;
import flixel.util.FlxStringUtil;

/**
 * ...
 * @author Dave
 */
class RuleLetterCount extends Rule
{

	public function new() 
	{
		super();
		this.description = "The word scores 1 point for each letter it contains.";
		this.shortDesc = "1 point per letter";
	}
	
	override public function scoreWord(word:String):Int 
	{
		return word.length-1;
		
	}
	
}