/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
import flash.display.Bitmap;
import flash.ui.Keyboard;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import mx.utils.ObjectUtil;

import theGame.data.location1.maps.Maps;
import theGame.explosionss.Explosion;
import theGame.maps.Map;
import theGame.maps.builders.MapBlockBuilder;

public class Utils {

    public static function getClass(value:*):Class {
        return getDefinitionByName(getQualifiedClassName(value)) as Class;
    }

    public static function getAfterExplosionBitmap(expl:Explosion):Bitmap {
        var explClass:Class = getDefinitionByName(ObjectUtil.getClassInfo(expl).name) as Class;
        return (new explClass["AFTER"]()) as Bitmap;
    }

    public static function isArrowKey(code:uint):Boolean {
        return code == Keyboard.LEFT || code == Keyboard.RIGHT || code == Keyboard.UP || code == Keyboard.DOWN;
    }

    public static function arrowKeyCodeToDirection(code:uint):Direction {
        switch (code) {
            case Keyboard.LEFT:
                return Direction.LEFT;
            case Keyboard.RIGHT:
                return Direction.RIGHT;
            case Keyboard.UP:
                return Direction.UP;
            case Keyboard.DOWN:
                return Direction.DOWN;
        }
        throw new ArgumentError("Argument Code is not a valid keyboard arrow code");
    }

    public static function between(x1:Number, arg:Number, x2:Number):Boolean {
        if (x2 < x1) {
            throw ArgumentError("x1 must be less or equal than x2");
        }
        return arg <= x2 && arg >= x1;
    }

    public static function isCorrectGameName(name:String):Boolean {
        return name.length >= 3;

    }

    public static function makeMiniMap(blockBuilder:MapBlockBuilder):Map {
        return new Map(Maps.mapXmls[Maps.TEST_SINGLE_ID], blockBuilder);
    }
}
}