//shoutouts to captainkirb, she made the og script
//i realized i found the old title screen script pasted in discord so ima use that now, albeit slightly outdated but I remember what to change

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

    gf = new FlxSprite(500, 0);
    gf.frames = Paths.getSparrowAtlas('titlescreen/gfDanceTitle');
    gf.antialiasing = true;
    gf.animation.addByPrefix('dance', 'gfDance', 24, true);
    add(gf);
    gf.animation.play('dance');


    titleblack = new FlxSprite(-100, 0);
    titleblack.frames = Paths.getSparrowAtlas('titlescreen/logoBumpin');
    titleblack.antialiasing = true;
    titleblack.animation.addByPrefix('bump', 'logo bumpin', 24, true);
    titleblack.updateHitbox();
	 titleblack.color = FlxColor.BLACK;
    add(titleblack);
    titleblack.animation.play('bump');
     
    title = new FlxSprite(-100, 0);
    title.frames = Paths.getSparrowAtlas('titlescreen/logoBumpin');
    title.antialiasing = true;
    title.animation.addByPrefix('bump', 'logo bumpin', 24, true);
    title.updateHitbox();
    add(title);
    title.animation.play('bump');
     
     
FlxTween.tween(titleblack, {y: titleblack.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: 4});
FlxTween.tween(title, {y: title.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: 4, startDelay: 0.15});

        FlxG.sound.playMusic('/music/title.mp3', 0, false);

        FlxG.sound.music.fadeIn(4, 0, 0.7);
    }

    var transitioning:Bool = false;

    {
        if (FlxG.keys.justPressed.ENTER && !transitioning)
        {
            transitioning = true;
            FlxG.sound.music.stop();

            new FlxTimer().start(2, function(tmr:FlxTimer)
            {
                FlxG.switchState(new PlayState());
            });
            FlxG.sound.play('/music/titleShoot.mp3', 0.7);
				
        }
    }








//titleblack.FlxColor = BLACK
//couldn't get this to work for the life of me, so i used some more fnf code from 0.1 but edited
//https://github.com/ninjamuffin99/Funkin/commit/8ec6f229aa5f4b793bac7517878103be6c6a19ba#