/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
public class Pixel {
    private var _value:uint;

    public function Pixel(n1:uint, n2:int = 0, n3:int = 0, n4:int = 0) {
        if (arguments.length == 1) {
            value = n1;
        } else {
            value = n1 << 24 | n2 << 16 | n3 << 8 | n4;
        }
    }

    public function get value():uint {
        return _value;
    }

    public function set value(value:uint):void {
        _value = value;
    }

    public function setAlpha(n:int):void {
        if (n < 0 || n > 255) {
            throw new RangeError("Supplied value must be range in 0-255");
        }

        value &= (0x00ffffff);
        value |= (n << 24);
    }

    public function setRed(n:int):void {
        if (n < 0 || n > 255) {
            throw new RangeError("Supplied value must be range in 0-255");
        }

        value &= (0xff00ffff);
        value |= (n << 16);
    }

    public function setGreen(n:int):void {
        if (n < 0 || n > 255) {
            throw new RangeError("Supplied value must be range in 0-255");
        }

        value &= (0xffff00ff);
        value |= (n << 8);
    }

    public function setBlue(n:int):void {
        if (n < 0 || n > 255) {
            throw new RangeError("Supplied value must be range in 0-255");
        }

        value &= (0xffffff00);
        value |= (n);
    }

    public function getAlpha():int {
        return (value >> 24) & 0xff;
    }

    public function getRed():int {
        return (value >> 16) & 0xff;
    }

    public function getGreen():int {
        return (value >> 8) & 0xff;
    }

    public function getBlue():int {
        return (value) & 0xff;
    }

    public function setRandomDifference(sh:int):void {
        var r:int = getRed();
        var g:int = getGreen();
        var b:int = getBlue();

        var arr:Array = [-1, 1];
        var r1:int = Math.round(Math.random() * arr.length);
        var r2:int = Math.round(Math.random() * arr.length);
        var r3:int = Math.round(Math.random() * arr.length);
        if (r1 == arr.length)
            r1 = 0;
        if (r2 == arr.length)
            r2 = 0;
        if (r3 == arr.length)
            r3 = 0;

        var sign1:int = 1;
        var sign2:int = 1;
        var sign3:int = 1;

        var diff1:int = Math.round(Math.random() * 30 - 15);
        var diff2:int = Math.round(Math.random() * 30 - 15);
        var diff3:int = Math.round(Math.random() * 30 - 15);

        r += sign1 * sh + diff1;
        g += sign2 * sh + diff2;
        b += sign3 * sh + diff3;

        if (r > 255)
            r = 255;
        if (r < 0)
            r = 0;

        if (g > 255)
            g = 255;
        if (g < 0)
            g = 0;

        if (b > 255)
            b = 255;
        if (b < 0)
            b = 0;

        value = new Pixel(100, r, g, b).value;
    }

    public function setDifference(sh:int):void {
        var r:int = getRed();
        var g:int = getGreen();
        var b:int = getBlue();

        r += sh;
        g += sh;
        b += sh;

        if (r > 255)
            r = 255;
        if (r < 0)
            r = 0;

        if (g > 255)
            g = 255;
        if (g < 0)
            g = 0;

        if (b > 255)
            b = 255;
        if (b < 0)
            b = 0;

        value = new Pixel(100, r, g, b).value;
    }

    public function multiplay(valueP:uint):void {
        value *= valueP;
    }
}
}