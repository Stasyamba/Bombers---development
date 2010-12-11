/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.health_bar {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class HealthBar {

    private static var green_side:Bitmap;
    private static var green_center:Bitmap;
    private static var yellow_side:Bitmap;
    private static var yellow_center:Bitmap;
    private static var red_side:Bitmap;
    private static var red_center:Bitmap;

    [Embed(source="../../../data/location1/images/health_bar/green_side.png")]
    public static const green_side_class:Class;
    [Embed(source="../../../data/location1/images/health_bar/green_center.png")]
    public static const green_center_class:Class;
    [Embed(source="../../../data/location1/images/health_bar/yellow_side.png")]
    public static const yellow_side_class:Class;
    [Embed(source="../../../data/location1/images/health_bar/yellow_center.png")]
    public static const yellow_center_class:Class;
    [Embed(source="../../../data/location1/images/health_bar/red_side.png")]
    public static const red_side_class:Class;
    [Embed(source="../../../data/location1/images/health_bar/red_center.png")]
    public static const red_center_class:Class;

    public static function get GREEN_SIDE():BitmapData {
        if (green_side == null)
            green_side = new green_side_class() as Bitmap;
        return green_side.bitmapData;
    }

    public static function get GREEN_CENTER():BitmapData {
        if (green_center == null)
            green_center = new green_center_class() as Bitmap;
        return green_center.bitmapData;
    }

    public static function get YELLOW_SIDE():BitmapData {
        if (yellow_side == null)
            yellow_side = new yellow_side_class() as Bitmap;
        return yellow_side.bitmapData;
    }

    public static function get YELLOW_CENTER():BitmapData {
        if (yellow_center == null)
            yellow_center = new yellow_center_class() as Bitmap;
        return yellow_center.bitmapData;
    }

    public static function get RED_SIDE():BitmapData {
        if (red_side == null)
            red_side = new red_side_class() as Bitmap;
        return red_side.bitmapData;
    }

    public static function get RED_CENTER():BitmapData {
        if (red_center == null)
            red_center = new red_center_class() as Bitmap;
        return red_center.bitmapData;
    }
}
}