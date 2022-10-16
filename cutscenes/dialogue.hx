// Original dialogue code from VS. Blackjack: https://gamebanana.com/mods/390469 | Modified by skid.xml/skid.zip

import("haxe.Json");
import("openfl.utils.Assets");
import("flixel.addons.text.FlxTypeText");
import("FlxColor");

var current = 0;
var bg:FlxSprite;
var box:FlxSprite;
var boxOutline:FlxSprite;
var dialogue:Dynamic = {};
var text:FlxTypeText;
var text:FlxText;
var icon:FlxSprite;

function create() {
    trace(PlayState.song.song);

    if (PlayState.endCutscene) {
        PlayState.forEach(function(m) {
            if (Std.isOfType(m, FlxSprite) && m.cameras.contains(PlayState.camHUD))
                FlxTween.tween(m, {alpha: 0}, 0.25);
        }, true);
        for(str in PlayState.playerStrums)
            FlxTween.tween(str, {alpha: 0}, 0.25);
        for(str in PlayState.cpuStrums)
            FlxTween.tween(str, {alpha: 0}, 0.25);
        
    }

    dialogue = Json.parse(Assets.getText(Paths.json(PlayState.song.song + (isEndCutscene ? "/end-dialogue" : "/dialogue"))));
    if (dialogue.noBG == null) dialogue.noBG = false;
    PlayState.isWidescreen = false;

    switch(PlayState.song.song.toLowerCase()) {
        default:
            FlxG.sound.playMusic(Paths.music("breakfast"), 0);
    }
    FlxG.sound.music.fadeIn(0.5, 0, 1 / 5);

    box = new FlxSprite(0, 530).loadGraphic(Paths.image('box'));
    box.cameras = [PlayState.camHUD];
    box.antialiasing = true;
    box.scrollFactor.set();

    bg = new FlxSprite();
    bg.cameras = [PlayState.camHUD];
    bg.scrollFactor.set();
    bg.antialiasing = true;
    
    if (dialogue.noBG != true)
        PlayState.add(bg);

    PlayState.add(box);

    icon = new FlxSprite(20, 550);
    icon.loadGraphic(Paths.file('characters/bf/icon.png', "IMAGE"), true, 150, 150);
    icon.cameras = [PlayState.camHUD];
    icon.antialiasing = true;
    PlayState.add(icon);

    text = new FlxTypeText(icon.x + 170, box.y + 20, FlxG.width - 40 - 170, "-");
    text.font = "VCR OSD Mono";
    text.size = 24;
    text.color = 0xFFFFFFFF;
    text.cameras = [PlayState.camHUD];
    text.scrollFactor.set();


    PlayState.add(text);

    infoText = new FlxText(10, box.y - 48, 0, "Press ENTER to Proceed\nPress Z to Skip\n");
    infoText.font = "VCR OSD Mono";
    infoText.size = 20;
    infoText.color = 0xFFFFFFFF;
    infoText.cameras = [PlayState.camHUD];
    infoText.scrollFactor.set();

    PlayState.add(infoText);

    PlayState.camHUD.visible = true;
    PlayState.camHUD.alpha = 1;
    if (dialogue.noBG != true) {
        PlayState.camHUD.bgColor = 0xFF0000000;
        PlayState.camHUD.flash(0xFF000000, 2);
    } else {
        PlayState.camHUD.bgColor = 0;
    }

    switchPage();
}

var lastLoadedImage = Paths.file('characters/bf/icon.png', "IMAGE");
function switchPage() {
    if (dialogue.dialogue[current].img != null) {
        bg.loadGraphic(Paths.image(dialogue.dialogue[current].img));
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.updateHitbox();
        var maxScale = Math.min(bg.scale.x, bg.scale.y);
        bg.scale.set(maxScale, maxScale);
    }
    text.resetText(dialogue.dialogue[current].text);
    text.start();
    if (dialogue.dialogue[current].fadeOut == true) {
        FlxG.sound.music.fadeOut(1);
    }
    if (dialogue.dialogue[current].shake == true) {
        FlxG.camera.visible = false;
    }

    var p = Paths.file('characters/' + dialogue.dialogue[current].char + '/icon.png', "IMAGE");
    if (p != lastLoadedImage)
        icon.loadGraphic(lastLoadedImage = p, true, 150, 150);
}

var fadeTime:Float = 0;
var fadingAway = false;

var bopTime:Float = 0;
var crochet = (60 / 93);
function update(elapsed:Float) {
    bopTime += elapsed;
    if (bopTime > crochet) {
        bopTime %= crochet;
        for(c in PlayState.members)
            if (Std.isOfType(c, Character)) {
                c.lastNoteHitTime = -69420;
                c.dance(true);
            }
    }
    if (fadingAway) {
        fadeTime += elapsed;
        if (fadeTime > 0.5) {
            PlayState.remove(bg);
            PlayState.remove(box);
            PlayState.remove(text);
            PlayState.remove(infoText);
            bg.destroy();
            box.destroy();
            text.destroy();
            infoText.destroy();
            icon.destroy();
            startCountdown();
            PlayState.isWidescreen = true;
            var e = FlxG.sound.music;
            e.destroy();
            FlxG.sound.music = null;
        } else {
            icon.alpha = text.alpha = infoText.alpha = bg.alpha = box.alpha = 1 - (FlxEase.quintOut(fadeTime * 2));
        }
    } else {
        if (!fadingAway) {
            if (FlxG.keys.justPressed.Z) {
                FlxG.sound.play(Paths.sound('cancelMenu'));
                FlxG.sound.music.fadeOut(0.5);
                fadingAway = true;
                PlayState.camHUD.bgColor = 0;
                if (PlayState.endCutscene) {
                    end();
                }
            }
            if (FlxG.keys.justPressed.ENTER) {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                current++;
                if (current >= dialogue.dialogue.length) {
                    FlxG.sound.music.fadeOut(0.5);
                    fadingAway = true;
                    PlayState.camHUD.bgColor = 0;
                } else {
                    switchPage();
                }
            }
        }
    }
}