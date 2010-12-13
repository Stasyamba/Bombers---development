/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.skins {
import flash.display.Bitmap;
import flash.utils.ByteArray;

import theGame.bombers.skin.BomberSkin;
import theGame.bombers.skin.SkinElement;

public class BomberSkins {

    //---fury
    [Embed(source="../images/skins/fury_left.png")]
    public static const fury_left:Class;
    [Embed(source="../images/skins/fury_right.png")]
    public static const fury_right:Class;
    [Embed(source="../images/skins/fury_up.png")]
    public static const fury_up:Class;
    [Embed(source="../images/skins/fury_down.png")]
    public static const fury_down:Class;
    [Embed(source="../images/skins/fury_down.png")]
    public static const fury_none:Class;

    [Embed(source="../images/skins/fury_left_mask.png")]
    public static const fury_left_mask:Class;
    [Embed(source="../images/skins/fury_right_mask.png")]
    public static const fury_right_mask:Class;
    [Embed(source="../images/skins/fury_up_mask.png")]
    public static const fury_up_mask:Class;
    [Embed(source="../images/skins/fury_down_mask.png")]
    public static const fury_down_mask:Class;
    [Embed(source="../images/skins/fury_down_mask.png")]
    public static const fury_none_mask:Class;

    private static var fury_skin:BomberSkin;

    public static function get fury():BomberSkin {
        if (fury_skin == null) {
            fury_skin = makeSkin("fury");
        }
        return fury_skin;
    }

    //---robot
    [Embed(source="../images/skins/robot_left.png")]
    public static const robot_left:Class;
    [Embed(source="../images/skins/robot_right.png")]
    public static const robot_right:Class;
    [Embed(source="../images/skins/robot_up.png")]
    public static const robot_up:Class;
    [Embed(source="../images/skins/robot_down.png")]
    public static const robot_down:Class;
    [Embed(source="../images/skins/robot_down.png")]
    public static const robot_none:Class;

    [Embed(source="../images/skins/robot_left_mask.png")]
    public static const robot_left_mask:Class;
    [Embed(source="../images/skins/robot_right_mask.png")]
    public static const robot_right_mask:Class;
    [Embed(source="../images/skins/robot_up_mask.png")]
    public static const robot_up_mask:Class;
    [Embed(source="../images/skins/robot_down_mask.png")]
    public static const robot_down_mask:Class;
    [Embed(source="../images/skins/robot_down_mask.png")]
    public static const robot_none_mask:Class;

    private static var robot_skin:BomberSkin;

    public static function get robot():BomberSkin {
        if (robot_skin == null) {
            robot_skin = makeSkin("robot");
        }
        return robot_skin;
    }

    // ---  utils
    [Embed(source="BomberSkins.xml",mimeType="application/octet-stream")]
    private static const xmlClass:Class;
    private static var _xml:XML;
    private static function get xml():XML {
        if (_xml == null) {
            var file:ByteArray = new xmlClass();
            var str:String = file.readUTFBytes(file.length);
            _xml = new XML(str);
        }
        return _xml;
    }

    private static function makeSkin(name:String):BomberSkin {
        var skinXml:XMLList = xml.child(name);
        var colorsObject:Object = new Object();
        var skinElements:Object = new Object();

        for each (var skinColor:XML in skinXml.colors.SkinColor) {
            var pColor:String = skinColor.@val;
            colorsObject[pColor] = {color:uint(skinColor.color.@val),blendMode:skinColor.blendMode.@val,opacity:Number(skinColor.opacity.@val)}
        }
        skinElements.left = new SkinElement(new BomberSkins[name + "_left"]() as Bitmap, new BomberSkins[name + "_left_mask"]() as Bitmap)
        skinElements.right = new SkinElement(new BomberSkins[name + "_right"]() as Bitmap, new BomberSkins[name + "_right_mask"]() as Bitmap)
        skinElements.up = new SkinElement(new BomberSkins[name + "_up"]() as Bitmap, new BomberSkins[name + "_up_mask"]() as Bitmap)
        skinElements.down = new SkinElement(new BomberSkins[name + "_down"]() as Bitmap, new BomberSkins[name + "_down_mask"]() as Bitmap)
        skinElements.none = new SkinElement(new BomberSkins[name + "_none"]() as Bitmap, new BomberSkins[name + "_none_mask"]() as Bitmap)

        return new BomberSkin(name, skinElements, colorsObject);
    }
}
}