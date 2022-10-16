var blackFword:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('StartScreens/black'));
var coolthing:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('StartScreens/July/intro'));

function create() {
    blackFword.screenCenter();
    blackFword.cameras = [PlayState.camHUD];
    PlayState.add(blackFword);
    coolthing.screenCenter();
	 coolthing.scale.x = 5;
	 coolthing.scale.y = 5;
	 coolthing.animation.play('intro');
    coolthing.cameras = [PlayState.camHUD];
    

    new FlxTimer().start(1.9, function(tmr:FlxTimer)
    {
        FlxTween.tween(blackFword, {alpha: 0}, 1);
        FlxTween.tween(coolthing, {alpha: 0}, 1);
		  coolthing.animation.play('outro');
    });
}

function onCountdown(countdown:Int) {
    if (countdown == 3) {
        Conductor.songPosition = 0;
    }
    return false;
}