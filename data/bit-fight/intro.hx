var disclaimer:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('disclaimer/nick'));

function create() {
    disclaimer.screenCenter();
    disclaimer.cameras = [PlayState.camHUD];
	 disclaimer.scale.x = 0.5;
    disclaimer.scale.y = 0.5;
    PlayState.add(disclaimer);

    new FlxTimer().start(1.9, function(tmr:FlxTimer)
    {
        FlxTween.tween(disclaimer, {alpha: 0}, 1, {startDelay: 7.5});

    });
}

function onCountdown(countdown:Int) {
    if (countdown == 3) {
        Conductor.songPosition = 0;
    }
    return false;
}