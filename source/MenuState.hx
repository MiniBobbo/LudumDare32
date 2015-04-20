package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import haxe.ds.Vector;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	var bg:FlxSprite;
	var players:Vector<FlxButton>;
	
	var n:Vector<FlxText>;
	var ai:Vector<FlxButton>;
	
	var startDebate:FlxButton;
	
	var title:FlxText;
	
	var p1Select:Int = 2;
	var p2Select:Int = 1;

	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.sound.pause();
		Reg.init();
		bg = new FlxSprite(0, 0, "assets/images/bg.png");
		
		players = new Vector<FlxButton>(2);
		n = new Vector<FlxText>(2);
		ai = new Vector<FlxButton>(2);
		
		players[0] = new FlxButton(80, 250, "", p1Change);
		changeGraphic();
		n[0] = new FlxText(30, 400, 300, Reg.names[0], 30);
		n[0].setFormat(null, 30, FlxColor.WHITE, "center");
		ai[0] = new FlxButton(30, 440, "", swapAI1);
		ai[0].makeGraphic(300, 30, FlxColor.TRANSPARENT);
		ai[0].label.setFormat(null, 30, FlxColor.WHITE, "center");
		if (Reg.compControlled[0])
		ai[0].text = "CPU";
		else
		ai[0].text = "Human";
		
		players[1]  = new FlxButton(550, 250, "", p2Change);
		changeGraphic(1);
		n[1] = new FlxText(470, 400, 300, Reg.names[1], 30);
		n[1].setFormat(null, 30, FlxColor.WHITE, "center");
		ai[1] = new FlxButton(470, 440, "", swapAI2);
		ai[1].makeGraphic(300, 30, FlxColor.TRANSPARENT);
		ai[1].label.setFormat(null, 30, FlxColor.WHITE, "center");
		if (Reg.compControlled[1])
		ai[1].text = "CPU";
		else
		ai[1].text = "Human";

		startDebate = new FlxButton(300, 200, "Start\nDebate", debateStart);
		startDebate.makeGraphic(200, 200, FlxColor.TRANSPARENT);
		startDebate.label.setFormat(null, 30, FlxColor.WHITE, "center");
		
		add(bg);
		add(players[0]);
		add(players[1]);
		add(n[0]);
		add(n[1]);
		add(ai[0]);
		add(ai[1]);
		add(startDebate);
		
		title = new FlxText(0, 0, 800, "The Great\nDebate", 150);
		title.setFormat(null, 70, FlxColor.WHITE, "center");
		add(title);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	public function p1Change() {
		p1Select++;
		if (p1Select == Reg.avatarList.length)
		p1Select = 0;
		Reg.playerAvatar[0] = Reg.avatarList[p1Select];
		changeGraphic();
		
	}
	public function p2Change() {
		p2Select++;
		if (p2Select == Reg.avatarList.length)
		p2Select = 0;
		Reg.playerAvatar[1] = Reg.avatarList[p2Select];
		changeGraphic(1);
			}
	
	public function swapAI1() {
		Reg.compControlled[0] = !Reg.compControlled[0];
		if (Reg.compControlled[0])
		ai[0].text = "CPU";
		else
		ai[0].text = "Human";
		
	}
	public function swapAI2() {
		Reg.compControlled[1] = !Reg.compControlled[1];
		if (Reg.compControlled[1])
		ai[1].text = "CPU";
		else
		ai[1].text = "Human";
		
	}
	
	public function debateStart() {
		FlxG.switchState(new PlayState());
	}
	
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	function changeGraphic(num:Int = 0):Void 
	{
		players[num].loadGraphic("assets/images/" + Reg.playerAvatar[num]+ ".png", true);
		players[num].animation.add("stand", [0]);
		players[num].animation.add("talk", [0,1,2,3], 10);
		players[num].animation.play("stand");
		if (num == 1)
		players[num].flipX = true;
	
	}
}