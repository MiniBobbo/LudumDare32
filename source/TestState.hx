package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class TestState extends FlxState
{
	var t:FlxText;
	
	override public function create():Void 
	{
		super.create();
		Reg.init();
		t = new FlxText(10, 10, 780);
		t.setFormat(null, 40, FlxColor.WHITE, "center");
		add(t);
		
		var abc:String = "abcdefg";
		var str = "";
		for(i in 0...abc.length) {
		str += i + ": " + (abc.charCodeAt(i)-96 ) + "\n";
		}
		
		t.text = str;
	}
	
		/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (FlxG.keys.anyJustPressed(["SPACE"])) {
			Reg.word = Reg.getRandomWord();
			
			var sArray = Reg.getRandomRebuttal().split("*");
			
			t.text = "";
			t.clearFormats();
			var letterCount = 0;
			
			for (i in 0...sArray.length) {
				var s = sArray[i];
				t.text += s;
				letterCount += s.length;
				if (i != sArray.length - 1) {
					t.text += Reg.word.substr(0, Reg.word.length - 1);
					t.addFormat(new FlxTextFormat(FlxColor.CORAL, true, false, null, letterCount, letterCount + Reg.word.length-1));
					letterCount += Reg.word.length -1;
				}
				
			}
			
		}
	}	
}