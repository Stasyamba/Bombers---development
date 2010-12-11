/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.mapObjects.bonuses {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class Bonuses {
    private static var add_bomb:Bitmap;
    private static var add_bomb_power:Bitmap;
    private static var add_speed:Bitmap;
    private static var heal:Bitmap;

    [Embed(source="../../images/bonuses/add_bomb.png")]
    public static const ADD_BOMB_CLASS:Class;
    [Embed(source="../../images/bonuses/add_bomb_power.png")]
    public static const ADD_BOMB_POWER_CLASS:Class;
    [Embed(source="../../images/bonuses/add_speed.png")]
    public static const ADD_SPEED_CLASS:Class;
    [Embed(source="../../images/bonuses/heal.png")]
    public static const HEAL_CLASS:Class;

    public static function get ADD_BOMB():BitmapData {
        if (add_bomb == null)
            add_bomb = new ADD_BOMB_CLASS() as Bitmap;
        return add_bomb.bitmapData;
    }
    public static function get ADD_BOMB_POWER():BitmapData {
        if (add_bomb_power == null)
            add_bomb_power = new ADD_BOMB_POWER_CLASS() as Bitmap;
        return add_bomb_power.bitmapData;
    }
    public static function get ADD_SPEED():BitmapData {
        if (add_speed == null)
            add_speed = new ADD_SPEED_CLASS() as Bitmap;
        return add_speed.bitmapData;
    }
    public static function get HEAL():BitmapData {
        if (heal == null)
            heal = new HEAL_CLASS() as Bitmap;
        return heal.bitmapData;
    }


}
}