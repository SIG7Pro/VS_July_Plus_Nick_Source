//shoutouts to captainkirb, she made the og script
var curtains:FlxSprite;
var bg:FlxSprite;
var gf:FlxSprite;

function create(){
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('titlescreen/stageback'));
    bg.screenCenter();
    add(bg);

    curtains = new FlxSprite(0, 0).loadGraphic(Paths.image('titlescreen/stagecurtains'));
    curtains.screenCenter();
    curtains.scale.x = 0.5;
    curtains.scale.y = 0.5;
    curtains.y -= 20;
    add(curtains);

    gf = new FlxSprite(545, 0);
    gf.frames = Paths.getSparrowAtlas('titlescreen/gfDanceTitle');
    gf.antialiasing = true;
    gf.animation.addByPrefix('dance', 'gfDance', 24, true);
    add(gf);
    gf.animation.play('dance');
	 
	 title = new FlxSprite(-130, 0);
    title.frames = Paths.getSparrowAtlas('titlescreen/logoBumpin');
    title.antialiasing = true;
    title.animation.addByPrefix('bump', 'logo bumpin', 24, true);
    add(title);
    title.animation.play('bump');
}