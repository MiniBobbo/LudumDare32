package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/adjectives.txt", "assets/data/adjectives.txt");
			type.set ("assets/data/adjectives.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/adverbs.txt", "assets/data/adverbs.txt");
			type.set ("assets/data/adverbs.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/arguments.txt", "assets/data/arguments.txt");
			type.set ("assets/data/arguments.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/nouns.txt", "assets/data/nouns.txt");
			type.set ("assets/data/nouns.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/rebuttals.txt", "assets/data/rebuttals.txt");
			type.set ("assets/data/rebuttals.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/verbs.txt", "assets/data/verbs.txt");
			type.set ("assets/data/verbs.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/words.txt", "assets/data/words.txt");
			type.set ("assets/data/words.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/bg.png", "assets/images/bg.png");
			type.set ("assets/images/bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/crowd.png", "assets/images/crowd.png");
			type.set ("assets/images/crowd.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/einstein.png", "assets/images/einstein.png");
			type.set ("assets/images/einstein.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/layoutTest.png", "assets/images/layoutTest.png");
			type.set ("assets/images/layoutTest.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mod.png", "assets/images/mod.png");
			type.set ("assets/images/mod.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/neildegrassetyson.png", "assets/images/neildegrassetyson.png");
			type.set ("assets/images/neildegrassetyson.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/speechBubble.png", "assets/images/speechBubble.png");
			type.set ("assets/images/speechBubble.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/thoughtBubble.png", "assets/images/thoughtBubble.png");
			type.set ("assets/images/thoughtBubble.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
