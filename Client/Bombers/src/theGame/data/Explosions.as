/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class Explosions {

    private static var cross:Bitmap;
    private static var vertical:Bitmap;
    private static var horizontal:Bitmap;
    private static var left:Bitmap;
    private static var right:Bitmap;
    private static var up:Bitmap;
    private static var down:Bitmap;

    //todo: after should go to mapBlock
    private static var print:Bitmap;

    [Embed(source="../data/location1/images/explosions/cross.png")]
    public static const CROSS_CLASS:Class;

    [Embed(source="../data/location1/images/explosions/horizontal.png")]
    public static const HORIZONTAL_CLASS:Class;
    [Embed(source="../data/location1/images/explosions/vertical.png")]
    public static const VERTICAL_CLASS:Class;
    [Embed(source="../data/location1/images/explosions/left.png")]
    public static const LEFT_CLASS:Class;
    [Embed(source="../data/location1/images/explosions/right.png")]
    public static const RIGHT_CLASS:Class;
    [Embed(source="../data/location1/images/explosions/up.png")]
    public static const UP_CLASS:Class;
    [Embed(source="../data/location1/images/explosions/down.png")]
    public static const DOWN_CLASS:Class;
    [Embed(source="location1/images/explosions/print.png")]
    public static const PRINT_CLASS:Class;

    public static function get CROSS():BitmapData {
        if (cross == null)
            cross = new CROSS_CLASS() as Bitmap;
        return cross.bitmapData;
    }

    public static function get HORIZONTAL():BitmapData {
        if (horizontal == null)
            horizontal = new HORIZONTAL_CLASS() as Bitmap;
        return horizontal.bitmapData;
    }

    public static function get VERTICAL():BitmapData {
        if (vertical == null)
            vertical = new VERTICAL_CLASS() as Bitmap;
        return vertical.bitmapData;
    }

    public static function get LEFT():BitmapData {
        if (left == null)
            left = new LEFT_CLASS() as Bitmap;
        return left.bitmapData;
    }

    public static function get RIGHT():BitmapData {
        if (right == null)
            right = new RIGHT_CLASS() as Bitmap;
        return right.bitmapData;
    }

    public static function get UP():BitmapData {
        if (up == null)
            up = new UP_CLASS() as Bitmap;
        return up.bitmapData;
    }

    public static function get DOWN():BitmapData {
        if (down == null)
            down = new DOWN_CLASS() as Bitmap;
        return down.bitmapData;
    }

    public static function get PRINT():BitmapData {
        if (print == null)
            print = new PRINT_CLASS() as Bitmap;
        return print.bitmapData;
    }


    // die explosions

    [Embed(source="../data/location1/images/explosions/die0.png")]
    public static const die0_class:Class;
    [Embed(source="../data/location1/images/explosions/die1.png")]
    public static const die1_class:Class;
    [Embed(source="../data/location1/images/explosions/die2.png")]
    public static const die2_class:Class;

    private static var die0:Bitmap;
    private static var die1:Bitmap;
    private static var die2:Bitmap;

    public static function get DIE0():BitmapData {
        if (die0 == null)
            die0 = new die0_class() as Bitmap;
        return die0.bitmapData;
    }

    public static function get DIE1():BitmapData {
        if (die1 == null)
            die1 = new die1_class() as Bitmap;
        return die1.bitmapData;
    }

    public static function get DIE2():BitmapData {
        if (die2 == null)
            die2 = new die2_class() as Bitmap;
        return die2.bitmapData;
    }

}
}