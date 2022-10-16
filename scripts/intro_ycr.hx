var blackFuck:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('StartScreens/black'));
var startCircle:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('StartScreens/CircleTooSlow'));
var startText:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('StartScreens/TextTooSlow'));

function create() {
    blackFuck.screenCenter();
    blackFuck.cameras = [PlayState.camHUD];
    PlayState.add(blackFuck);
    startCircle.screenCenter();
    startCircle.cameras = [PlayState.camHUD];
    PlayState.add(startCircle);
    startText.screenCenter();
    startText.cameras = [PlayState.camHUD];
    PlayState.add(startText);

    new FlxTimer().start(1.9, function(tmr:FlxTimer)
    {
        FlxTween.tween(blackFuck, {alpha: 0}, 1);
        FlxTween.tween(startCircle, {alpha: 0}, 1);
        FlxTween.tween(startText, {alpha: 0}, 1);
    });
}

function onCountdown(countdown:Int) {
    if (countdown == 3) {
        Conductor.songPosition = 0;
    }
    return false;
}