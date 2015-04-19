package ai;
import flixel.util.FlxRandom;
import rules.Rule;

/**
 * ...
 * @author Dave
 */
class AI
{

	
	public function new() 
	{
		
	}
	
	/**
	 * Returns the computer's choice for this round.  If not overwritten, then it will just be random.
	 * @param	words The list of words.
	 * @param	rule The secret rule that the debate is running on.
	 */
	public function pickWord(words:Array<String>, rule:Rule) {
		return FlxRandom.intRanged(0, 3);
	}
	
}