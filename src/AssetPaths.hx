package;

import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import openfl.utils.Assets;

using StringTools;

class AssetPaths
{
	public static inline function data(key:String):String
	{
		return 'assets/data/$key.json';
	}

	public static inline function script(key:String):String
	{
		return 'assets/data/$key.hxs';
	}

	public static inline function sound(key:String):String
	{
		return 'assets/sounds/$key.wav';
	}

	public static inline function music(key:String):String
	{
		return 'assets/music/$key.ogg';
	}

	public static inline function shader(key:String):String
	{
		return 'assets/shaders/$key';
	}

	public static inline function font(key:String):String
	{
		return 'assets/fonts/$key';
	}

	public static inline function sprite(key:String):String
	{
		return 'assets/images/$key.png';
	}

	public static function spritesheet(key:String):FlxAtlasFrames
	{
		var atlas:FlxAtlas = new FlxAtlas(AssetPaths.sprite(key));

		for (i in 0...Assets.list(IMAGE).filter(name -> name.startsWith('assets/images/$key')).length)
		{
			var file:String = AssetPaths.sprite(key + '_' + i);
			if (Assets.exists(file))
				atlas.addNode(file, key.substring(0, key.lastIndexOf('/') + 1) + i);
			else
				FlxG.log.error("Couldn't find frame " + file);
		}

		return atlas.getAtlasFrames();
	}
}
