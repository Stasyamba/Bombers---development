/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.mapObjects {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class BigObjectsSkins {

    private static var vk:Bitmap;

    [Embed(source="../images/bigObjects/vk.png")]
    public static const vk_class:Class;

    public static function get VK():BitmapData {
        if (vk == null)
            vk = new vk_class() as Bitmap;
        return vk.bitmapData;
    }
}
}