package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class Settings extends FlxTransitionableState
{
	var curOption:Int = 0;
	final options:Array<String> = ['Exit', 'Key Binds'];
	var optionsItems:FlxTypedGroup<FlxText>;

	var weatherMusic:FlxSound;

	override function create():Void
	{
		switch (Global.getWeather())
		{
			case 1:
				weatherMusic = FlxG.sound.load(AssetPaths.music('options_winter'), 1.0, true);
			case 3:
				weatherMusic = FlxG.sound.load(AssetPaths.music('options_summer'), 1.0, true);
			default:
				weatherMusic = FlxG.sound.load(AssetPaths.music('options_fall'), 1.0, true);
		}

		FlxG.sound.list.add(weatherMusic);

		var settings:FlxText = new FlxText(0, 20, 0, "SETTINGS", 48);
		settings.font = AssetPaths.font('DTM-Mono.otf');
		settings.screenCenter(X);
		settings.scrollFactor.set();
		add(settings);

		optionsItems = new FlxTypedGroup<FlxText>();
		add(optionsItems);

		for (i in 0...options.length)
		{
			var opt:FlxText = new FlxText(40, 80 + i * 30, 0, options[i].toUpperCase(), 24);
			opt.font = AssetPaths.font('DTM-Mono.otf');
			opt.ID = i;
			opt.scrollFactor.set();
			optionsItems.add(opt);
		}

		changeOption();

		FlxG.sound.play(AssetPaths.music('harpnoise'), () -> weatherMusic.play());

		super.create();
	}

	override function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.UP)
			changeOption(1);
		else if (FlxG.keys.justPressed.DOWN)
			changeOption(-1);
		else if (FlxG.keys.anyJustPressed(Global.binds.get('cancel')) && (weatherMusic != null && weatherMusic.playing))
		{
			weatherMusic.stop();

			FlxG.switchState(new Battle());
		}

		super.update(elapsed);
	}

	private function changeOption(num:Int = 0):Void
	{
		curOption = FlxMath.wrap(curOption + num, 0, options.length - 1);

		optionsItems.forEach(function(spr:FlxText)
		{
			if (spr.ID == curOption)
				spr.color = FlxColor.YELLOW;
			else
				spr.color = FlxColor.WHITE;
		});
	}
}
