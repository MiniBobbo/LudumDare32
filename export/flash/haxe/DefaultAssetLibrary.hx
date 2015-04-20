package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/adjectives.txt", __ASSET__assets_data_adjectives_txt);
		type.set ("assets/data/adjectives.txt", AssetType.TEXT);
		className.set ("assets/data/adverbs.txt", __ASSET__assets_data_adverbs_txt);
		type.set ("assets/data/adverbs.txt", AssetType.TEXT);
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/nouns/arguments.txt", __ASSET__assets_data_nouns_arguments_txt);
		type.set ("assets/data/nouns/arguments.txt", AssetType.TEXT);
		className.set ("assets/data/nouns/debateSubject.txt", __ASSET__assets_data_nouns_debatesubject_txt);
		type.set ("assets/data/nouns/debateSubject.txt", AssetType.TEXT);
		className.set ("assets/data/nouns/nouns.txt", __ASSET__assets_data_nouns_nouns_txt);
		type.set ("assets/data/nouns/nouns.txt", AssetType.TEXT);
		className.set ("assets/data/nouns/rebuttals.txt", __ASSET__assets_data_nouns_rebuttals_txt);
		type.set ("assets/data/nouns/rebuttals.txt", AssetType.TEXT);
		className.set ("assets/data/verbs.txt", __ASSET__assets_data_verbs_txt);
		type.set ("assets/data/verbs.txt", AssetType.TEXT);
		className.set ("assets/data/words.txt", __ASSET__assets_data_words_txt);
		type.set ("assets/data/words.txt", AssetType.TEXT);
		className.set ("assets/images/Aristotle.png", __ASSET__assets_images_aristotle_png);
		type.set ("assets/images/Aristotle.png", AssetType.IMAGE);
		className.set ("assets/images/bg.png", __ASSET__assets_images_bg_png);
		type.set ("assets/images/bg.png", AssetType.IMAGE);
		className.set ("assets/images/crowd.png", __ASSET__assets_images_crowd_png);
		type.set ("assets/images/crowd.png", AssetType.IMAGE);
		className.set ("assets/images/einstein.png", __ASSET__assets_images_einstein_png);
		type.set ("assets/images/einstein.png", AssetType.IMAGE);
		className.set ("assets/images/hal9000.png", __ASSET__assets_images_hal9000_png);
		type.set ("assets/images/hal9000.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/layoutTest.png", __ASSET__assets_images_layouttest_png);
		type.set ("assets/images/layoutTest.png", AssetType.IMAGE);
		className.set ("assets/images/mod.png", __ASSET__assets_images_mod_png);
		type.set ("assets/images/mod.png", AssetType.IMAGE);
		className.set ("assets/images/neildegrassetyson.png", __ASSET__assets_images_neildegrassetyson_png);
		type.set ("assets/images/neildegrassetyson.png", AssetType.IMAGE);
		className.set ("assets/images/speechBubble.png", __ASSET__assets_images_speechbubble_png);
		type.set ("assets/images/speechBubble.png", AssetType.IMAGE);
		className.set ("assets/images/thoughtBubble.png", __ASSET__assets_images_thoughtbubble_png);
		type.set ("assets/images/thoughtBubble.png", AssetType.IMAGE);
		className.set ("assets/music/main.mp3", __ASSET__assets_music_main_mp3);
		type.set ("assets/music/main.mp3", AssetType.MUSIC);
		className.set ("assets/music/main.wav", __ASSET__assets_music_main_wav);
		type.set ("assets/music/main.wav", AssetType.SOUND);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/adjectives.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/adverbs.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/nouns/arguments.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/nouns/debateSubject.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/nouns/nouns.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/nouns/rebuttals.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/verbs.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/words.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Aristotle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/crowd.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/einstein.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hal9000.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/layoutTest.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mod.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/neildegrassetyson.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/speechBubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/thoughtBubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/main.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/main.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		var assetsPrefix = ApplicationMain.config.assetsPrefix;
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/adjectives.txt", __ASSET__assets_data_adjectives_txt);
		type.set ("assets/data/adjectives.txt", AssetType.TEXT);
		
		className.set ("assets/data/adverbs.txt", __ASSET__assets_data_adverbs_txt);
		type.set ("assets/data/adverbs.txt", AssetType.TEXT);
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/nouns/arguments.txt", __ASSET__assets_data_nouns_arguments_txt);
		type.set ("assets/data/nouns/arguments.txt", AssetType.TEXT);
		
		className.set ("assets/data/nouns/debateSubject.txt", __ASSET__assets_data_nouns_debatesubject_txt);
		type.set ("assets/data/nouns/debateSubject.txt", AssetType.TEXT);
		
		className.set ("assets/data/nouns/nouns.txt", __ASSET__assets_data_nouns_nouns_txt);
		type.set ("assets/data/nouns/nouns.txt", AssetType.TEXT);
		
		className.set ("assets/data/nouns/rebuttals.txt", __ASSET__assets_data_nouns_rebuttals_txt);
		type.set ("assets/data/nouns/rebuttals.txt", AssetType.TEXT);
		
		className.set ("assets/data/verbs.txt", __ASSET__assets_data_verbs_txt);
		type.set ("assets/data/verbs.txt", AssetType.TEXT);
		
		className.set ("assets/data/words.txt", __ASSET__assets_data_words_txt);
		type.set ("assets/data/words.txt", AssetType.TEXT);
		
		className.set ("assets/images/Aristotle.png", __ASSET__assets_images_aristotle_png);
		type.set ("assets/images/Aristotle.png", AssetType.IMAGE);
		
		className.set ("assets/images/bg.png", __ASSET__assets_images_bg_png);
		type.set ("assets/images/bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/crowd.png", __ASSET__assets_images_crowd_png);
		type.set ("assets/images/crowd.png", AssetType.IMAGE);
		
		className.set ("assets/images/einstein.png", __ASSET__assets_images_einstein_png);
		type.set ("assets/images/einstein.png", AssetType.IMAGE);
		
		className.set ("assets/images/hal9000.png", __ASSET__assets_images_hal9000_png);
		type.set ("assets/images/hal9000.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/layoutTest.png", __ASSET__assets_images_layouttest_png);
		type.set ("assets/images/layoutTest.png", AssetType.IMAGE);
		
		className.set ("assets/images/mod.png", __ASSET__assets_images_mod_png);
		type.set ("assets/images/mod.png", AssetType.IMAGE);
		
		className.set ("assets/images/neildegrassetyson.png", __ASSET__assets_images_neildegrassetyson_png);
		type.set ("assets/images/neildegrassetyson.png", AssetType.IMAGE);
		
		className.set ("assets/images/speechBubble.png", __ASSET__assets_images_speechbubble_png);
		type.set ("assets/images/speechBubble.png", AssetType.IMAGE);
		
		className.set ("assets/images/thoughtBubble.png", __ASSET__assets_images_thoughtbubble_png);
		type.set ("assets/images/thoughtBubble.png", AssetType.IMAGE);
		
		className.set ("assets/music/main.mp3", __ASSET__assets_music_main_mp3);
		type.set ("assets/music/main.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/main.wav", __ASSET__assets_music_main_wav);
		type.set ("assets/music/main.wav", AssetType.SOUND);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash)
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				handler (audioBuffer);
				
			});
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			handler (getAudioBuffer (id));
			
		}
		#else
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || html5)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_adjectives_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_adverbs_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_nouns_arguments_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_nouns_debatesubject_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_nouns_nouns_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_nouns_rebuttals_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_verbs_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_words_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_aristotle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_crowd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_einstein_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hal9000_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_layouttest_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_neildegrassetyson_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_speechbubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_thoughtbubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_main_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_main_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5





























#else



#if (windows || mac || linux)


@:file("assets/data/adjectives.txt") #if display private #end class __ASSET__assets_data_adjectives_txt extends lime.utils.ByteArray {}
@:file("assets/data/adverbs.txt") #if display private #end class __ASSET__assets_data_adverbs_txt extends lime.utils.ByteArray {}
@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/data/nouns/arguments.txt") #if display private #end class __ASSET__assets_data_nouns_arguments_txt extends lime.utils.ByteArray {}
@:file("assets/data/nouns/debateSubject.txt") #if display private #end class __ASSET__assets_data_nouns_debatesubject_txt extends lime.utils.ByteArray {}
@:file("assets/data/nouns/nouns.txt") #if display private #end class __ASSET__assets_data_nouns_nouns_txt extends lime.utils.ByteArray {}
@:file("assets/data/nouns/rebuttals.txt") #if display private #end class __ASSET__assets_data_nouns_rebuttals_txt extends lime.utils.ByteArray {}
@:file("assets/data/verbs.txt") #if display private #end class __ASSET__assets_data_verbs_txt extends lime.utils.ByteArray {}
@:file("assets/data/words.txt") #if display private #end class __ASSET__assets_data_words_txt extends lime.utils.ByteArray {}
@:image("assets/images/Aristotle.png") #if display private #end class __ASSET__assets_images_aristotle_png extends lime.graphics.Image {}
@:image("assets/images/bg.png") #if display private #end class __ASSET__assets_images_bg_png extends lime.graphics.Image {}
@:image("assets/images/crowd.png") #if display private #end class __ASSET__assets_images_crowd_png extends lime.graphics.Image {}
@:image("assets/images/einstein.png") #if display private #end class __ASSET__assets_images_einstein_png extends lime.graphics.Image {}
@:image("assets/images/hal9000.png") #if display private #end class __ASSET__assets_images_hal9000_png extends lime.graphics.Image {}
@:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends lime.utils.ByteArray {}
@:image("assets/images/layoutTest.png") #if display private #end class __ASSET__assets_images_layouttest_png extends lime.graphics.Image {}
@:image("assets/images/mod.png") #if display private #end class __ASSET__assets_images_mod_png extends lime.graphics.Image {}
@:image("assets/images/neildegrassetyson.png") #if display private #end class __ASSET__assets_images_neildegrassetyson_png extends lime.graphics.Image {}
@:image("assets/images/speechBubble.png") #if display private #end class __ASSET__assets_images_speechbubble_png extends lime.graphics.Image {}
@:image("assets/images/thoughtBubble.png") #if display private #end class __ASSET__assets_images_thoughtbubble_png extends lime.graphics.Image {}
@:file("assets/music/main.mp3") #if display private #end class __ASSET__assets_music_main_mp3 extends lime.utils.ByteArray {}
@:file("assets/music/main.wav") #if display private #end class __ASSET__assets_music_main_wav extends lime.utils.ByteArray {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,8/assets/sounds/beep.mp3") #if display private #end class __ASSET__assets_sounds_beep_mp3 extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,8/assets/sounds/flixel.mp3") #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends lime.utils.ByteArray {}



#end

#if openfl

#end

#end
#end

