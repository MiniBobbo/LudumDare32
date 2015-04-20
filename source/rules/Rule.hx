package rules;

/**
 * ...
 * @author Dave
 */
class Rule
{

	public var description:String = "This is the default description.  If you are seeing this the programmer stupidly forgot to set it for this rule.";
	public var shortDesc:String = "This is the default short description.  You shouldn't see this.";
	
	public function new() 
	{
		
	}
	
	/**
	 * Takes a word and scores is according to some criteria.
	 * 
	 * @param	word
	 * @return The score of the word.
	 */
	public function scoreWord(word:String):Int {
		return 0;
	}
	
}