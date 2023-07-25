package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class IntroMenu extends FlxState
{
	var bg:FlxSprite;
	var flowey:FlxSprite;

	override function create():Void
	{
		bg = new FlxSprite(0, -304, AssetPaths.background('floweyglow'));
		bg.scale.set(2, 2);
		bg.updateHitbox();
		add(bg);

		flowey = new FlxSprite(332, 402);
		flowey.frames = AssetPaths.spritesheet('flowey', [1]);
		flowey.scale.set(2, 2);
		flowey.updateHitbox();
		add(flowey);
		
		super.create();
	}

	override function update(elapsed:Float):Void
	{
		if (FlxG.keys.anyJustPressed(Global.binds.get('confirm')))
			FlxG.switchState(new Battle());

		super.update(elapsed);
	}
}
