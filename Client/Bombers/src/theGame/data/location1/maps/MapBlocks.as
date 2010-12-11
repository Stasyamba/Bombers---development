/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.maps {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class MapBlocks {

    [Embed(source="../images/maps/mapGrass.jpg")]
    private static var map_grass:Class;

    [Embed(source="../images/maps/blocks/box1.png")]
    private static var box1:Class;
    [Embed(source="../images/maps/blocks/box2.png")]
    private static var box2:Class;
    [Embed(source="../images/maps/blocks/box3.png")]
    private static var box3:Class;

    [Embed(source="../images/maps/blocks/wall.png")]
    private static var wall:Class;


    private static var mapGrassBitmap:Bitmap;
    private static var boxBitmaps:Vector.<Bitmap>;
    private static var wallBitmap:Bitmap;


    public static function MAP_GRASS():BitmapData {
        if (mapGrassBitmap == null)
            mapGrassBitmap = new map_grass();
        return mapGrassBitmap.bitmapData;
    }

    public static function get BOX():BitmapData {
        if (boxBitmaps == null){
            boxBitmaps = new Vector.<Bitmap>();
            boxBitmaps.push(new box1())
            boxBitmaps.push(new box2())
            boxBitmaps.push(new box3())
        }
        var i:int = int(Math.random()*3)
        return boxBitmaps[i].bitmapData;
    }

    public static function get WALL():BitmapData {
        if (wallBitmap == null)
            wallBitmap = new wall();
        return wallBitmap.bitmapData;
    }

   


//    public static function get(value:String):BitmapData {
//        var x:* = MapBlocksSkins[value]
//        if (x == null) return null;
//        return (x as Function).call();
//    }
}
}