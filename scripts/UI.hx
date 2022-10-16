package funkin;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;
import states.PlayState;

class UI extends FlxSpriteGroup
{
	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	public function new()
	{
		super();

		healthBarBG = new FlxSprite(0, FlxG.height * 0.875).loadGraphic(AssetManager.getAsset('healthBar', IMAGE, 'UI'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8));
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		// healthBar
		add(healthBar);

		var scoreBar:FlxText = new FlxText(FlxG.width / 2, healthBarBG.y + 40, 0, "", 20);
		scoreBar.setFormat(AssetManager.getAsset('vcr', FONT, 'fonts'), 20, FlxColor.WHITE);
		scoreBar.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.05);
		scoreBar.scrollFactor.set();
		add(scoreBar);

		scoreBar.text = "Score: 9000 - Accuracy: 100% - Combo Breaks: 0 - Rank: S+";
		scoreBar.x = ((FlxG.width / 2) - (scoreBar.width / 2));

		// ui stuffs!
		var cornerMark:FlxText = new FlxText(0, 0, 0, 'FOREVER ENGINE v1.0.0\n');
		cornerMark.setFormat(AssetManager.getAsset('vcr', FONT, 'fonts'), 18, FlxColor.WHITE);
		cornerMark.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
		add(cornerMark);
		cornerMark.setPosition(FlxG.width - (cornerMark.width + 5), 5);
		cornerMark.antialiasing = true;

		if (PlayState.song != null)
		{
			var centerMark:FlxText = new FlxText(0, 0, 0, '- ${PlayState.song.name.toUpperCase()} -\n');
			centerMark.setFormat(AssetManager.getAsset('vcr', FONT, 'fonts'), 24, FlxColor.WHITE);
			centerMark.setBorderStyle(OUTLINE, FlxColor.BLACK, 3);
			add(centerMark);
			centerMark.y = FlxG.height / 24;
			centerMark.screenCenter(X);
			centerMark.antialiasing = true;
		}
	}
}
