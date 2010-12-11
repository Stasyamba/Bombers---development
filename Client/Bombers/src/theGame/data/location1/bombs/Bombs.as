/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.bombs {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class Bombs {

    private static var regularBombBitmap:Bitmap;
    private static var atomBombBitmap:Bitmap;

    private static var blueGlowBitmap:Bitmap;
    private static var orangeGlowBitmap:Bitmap;
    private static var pinkGlowBitmap:Bitmap;
    private static var redGlowBitmap:Bitmap;

    [Embed(source="../images/bombs/regularBomb.png")]
    private static var regularBomb:Class;

    [Embed(source="../images/bombs/atomBomb.png")]
    private static var atomBomb:Class;

    [Embed(source="../images/bombs/blueGlow.png")]
    private static var blueGlow:Class;
    [Embed(source="../images/bombs/orangeGlow.png")]
    private static var orangeGlow:Class;
    [Embed(source="../images/bombs/pinkGlow.png")]
    private static var pinkGlow:Class;
    [Embed(source="../images/bombs/redGlow.png")]
    private static var redGlow:Class;

    public static function get REGULAR():BitmapData {
        if (regularBombBitmap == null){
            regularBombBitmap = new regularBomb();
            regularBombBitmap.smoothing = true;
        }
        return regularBombBitmap.bitmapData;
    }

    public static function get ATOM():BitmapData {
        if (atomBombBitmap == null){
            atomBombBitmap = new atomBomb();
            atomBombBitmap.smoothing = true;
        }
        return atomBombBitmap.bitmapData;
    }

    public static function get BLUE_GLOW():BitmapData {
        if (blueGlowBitmap == null){
            blueGlowBitmap = new blueGlow();
            blueGlowBitmap.smoothing = true;
        }
        return blueGlowBitmap.bitmapData;
    }
    public static function get ORANGE_GLOW():BitmapData {
        if (orangeGlowBitmap == null) {
            orangeGlowBitmap = new orangeGlow();
            orangeGlowBitmap.smoothing = true;
        }
        return orangeGlowBitmap.bitmapData;
    }
    public static function get PINK_GLOW():BitmapData {
        if (pinkGlowBitmap == null) {
            pinkGlowBitmap = new pinkGlow();
            pinkGlowBitmap.smoothing = true;
        }
        return pinkGlowBitmap.bitmapData;
    }
    public static function get RED_GLOW():BitmapData {
        if (redGlowBitmap == null) {
            redGlowBitmap = new redGlow();
            redGlowBitmap.smoothing = true;
        }
        return redGlowBitmap.bitmapData;
    }
}
}