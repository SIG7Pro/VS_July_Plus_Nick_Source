var creditJson = Paths.parseJson(PlayState.SONG.song.toLowerCase() + '/credits');
var assets = [
    [
        new FlxSprite(600, 202).loadGraphic(Paths.image('art')),
        new FlxSprite(600, 204).loadGraphic(Paths.image('song')),
        new FlxSprite(600, 206).loadGraphic(Paths.image('midi')),
        new FlxSprite(600, 208).loadGraphic(Paths.image('code'))
    ],
    [
        new FlxText(640, 202, 0, creditJson.art, 35),
        new FlxText(640, 304, 0, creditJson.song, 35),
        new FlxText(640, 406, 0, creditJson.midi, 35),
        new FlxText(640, 508, 0, creditJson.code, 35)
    ]
];
function create() {
    var diamondBG = new FlxSprite(640, -300).loadGraphic(Paths.image('diamondBG'));
    diamondBG.cameras = [camHUD];
    diamondBG.scale.set(2, 2);
    diamondBG.angle = -90;
    FlxTween.tween(diamondBG, {y: 280, angle: 0}, 0.7, {startDelay: 0.5, ease: FlxEase.backOut, onComplete: function(twn:FlxTween) {FlxTween.tween(diamondBG, {alpha: 0}, 1.5, {startDelay: 3.5});}});
    add(diamondBG);
    for (i in 0...assets[0].length)
    {
        assets[0][i].scale.set(2, 2);
        assets[0][i].alpha = 0;
        assets[0][i].cameras = [PlayState.camHUD];
        FlxTween.tween(assets[0][i], {alpha: 1}, 0.5, {startDelay: 1, onComplete: function(twn:FlxTween) {FlxTween.tween(assets[0][i], {alpha:0}, 1.5, {startDelay: 2.5});}});

        assets[1][i].alpha = 0;
        assets[1][i].cameras = [PlayState.camHUD];
        FlxTween.tween(assets[1][i], {alpha: 1}, 0.5, {startDelay: 1, onComplete: function(twn:FlxTween) {FlxTween.tween(assets[1][i], {alpha:0}, 1.5, {startDelay: 2.5});}});

        add(assets[0][i]);
        add(assets[1][i]);
    }
}