package rules;

/**
 * ...
 * @author Dave
 */
class RuleSmallWords extends Rule
{

	public function new() 
	{
		super();
		this.description = "The smaller the word, the higher the score.";
		this.shortDesc = "Small words";
	}
	
	override public function scoreWord(word:String):Int 
	{
		return 15 - word.length;
	}
	
}