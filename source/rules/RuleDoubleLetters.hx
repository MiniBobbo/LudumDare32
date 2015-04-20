package rules;

/**
 * ...
 * @author Dave
 */
class RuleDoubleLetters extends Rule
{

	public function new() 
	{
		super();
		this.description = "10 points when two letters appear together in a row.";
		this.shortDesc = "Double Letters";
	}
	
	override public function scoreWord(word:String):Int 
	{
		var score = 0;
		for (i in 0...word.length - 1) {
			if (word.charAt(i) == word.charAt(i + 1))
			score += 10;
		}
		
		return score;
		
	}
	
}