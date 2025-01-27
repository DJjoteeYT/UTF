package;

import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.FlxG;
import openfl.utils.Assets;

typedef SpriteSheetData =
{
	key:String,
	sheet:Array<SheetData>
}

typedef SheetData =
{
	animation:String,
	path:String,
	frames:Array<Int>
}

class AssetPaths
{
	public static inline function background(key:String):String
	{
		return 'assets/backgrounds/$key.png';
	}

	public static inline function font(key:String):String
	{
		return 'assets/fonts/$key';
	}

	public static inline function script(key:String):String
	{
		return 'assets/data/$key.hx';
	}

	public static inline function data(key:String):String
	{
		return 'assets/data/$key.json';
	}

	public static inline function music(key:String):String
	{
		return 'assets/music/$key.ogg';
	}

	public static inline function shader(key:String):String
	{
		return 'assets/shaders/$key';
	}

	public static inline function sound(key:String):String
	{
		return 'assets/sounds/$key.wav';
	}

	public static inline function sprite(key:String):String
	{
		return 'assets/sprites/$key.png';
	}

	public static function spritesheet(data:SpriteSheetData):FlxAtlasFrames
	{
		if (data == null)
			return null;

		var atlas:FlxAtlas = new FlxAtlas(AssetPaths.sprite(data.key), FlxPoint.weak(0, 0), FlxPoint.weak(0, 0));

		for (sheet in data.sheet)
		{
			for (frame in sheet.frames)
			{
				var file:String = AssetPaths.sprite(sheet.path + '_$frame');

				if (Assets.exists(file))
					atlas.addNode(Assets.getBitmapData(file, false), sheet.animation + frame);
				else
					atlas.addNode('flixel/images/logo/default.png', sheet.animation + frame);
			}
		}

		return atlas.getAtlasFrames();
	}
}
