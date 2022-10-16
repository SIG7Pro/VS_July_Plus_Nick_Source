scoreTxt = new FlxText(0, (h * (Settings.engineSettings.data.downscroll ? 0.075 : 0.9)) + 30, FlxG.width, "Score: 123456 | Misses: 0 | Accuracy: 100% (Simple) | Average: 5ms | S (MFC)", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), Std.int(Settings.engineSettings.data.scoreTextSize), FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scale.x = 1;
		scoreTxt.scale.y = 1;
		scoreTxt.antialiasing = true;
		scoreTxt.cameras = [camHUD];
		scoreTxt.screenCenter(X);
		scoreTxt.scrollFactor.set();