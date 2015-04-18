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
		
	}
	
	override public function scoreWord(word:String):Int 
	{
		return word.length-1;
		
	}
	
}