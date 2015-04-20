package rules;

/**
 * ...
 * @author Dave
 */
class RuleHighestLetter extends Rule
{

	
	public function new() 
	{
		super();
		this.description = "The word scores points for the highest letter in the alphabet it contains.";
		this.shortDesc = "Highest letter";
	}
	
		override public function scoreWord(word:String):Int 
		{
			var highest:Int = 0;
			for (i in 0...word.length) {
				if (word.charCodeAt(i) - 96 > highest)
				highest = word.charCodeAt(i) - 96;
			}
			
			return highest;
		}
}