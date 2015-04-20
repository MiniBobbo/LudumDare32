package rules;

/**
 * ...
 * @author Dave
 */
class RuleConsonants extends Rule
{

	public function new() 
	{
		super();
		this.description = "Word scores +2 points for each consonant and -1 per vowel.";
		this.shortDesc = "Consonant good.  Vowel bad.";
		
	}
	
	override public function scoreWord(word:String):Int 
	{
		var score:Int = 0;
		for (i in 0...word.length) {
			var c = word.charAt(i);
			if (c == "a" || c == "e" || c == "i" || c == "o" || c == "u" )
			score--;
			else
			score += 2;
			
		}
		
		return score;
	}
	
}