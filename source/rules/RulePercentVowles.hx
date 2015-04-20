package rules;

/**
 * ...
 * @author Dave
 */
class RulePercentVowles extends Rule
{

	public function new() 
	{
		super();
		this.description = "A word has a score equal to the percentage of vowels it contains.";
		this.shortDesc = "Percent vowels";
	}
	
	override public function scoreWord(word:String):Int 
	{
		var vowels:Int = 0;
		for (i in 0...word.length) {
			var c = word.charAt(i);
			if (c == "a" || c == "e" || c == "i" || c == "o" || c == "u" )
			vowels++;
			
		}
		
		return Std.int((vowels/word.length) * 100);
	}
	
}