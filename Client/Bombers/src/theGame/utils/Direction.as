/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
public class Direction {

    public static const NONE:Direction = new Direction(0,"none");
    public static const LEFT:Direction = new Direction(1,"left");
    public static const RIGHT:Direction = new Direction(2,"right");
    public static const UP:Direction = new Direction(3,"up");
    public static const DOWN:Direction = new Direction(4,"down");

    private var _value:int;
    private var _key:String;

    public static function isVertical(dir:Direction):Boolean {
        return dir == Direction.UP || dir == Direction.DOWN;
    }

    public static function isHorizontal(dir:Direction):Boolean {
        return dir == Direction.LEFT || dir == Direction.RIGHT;
    }

    function Direction(value:int,key:String) {
        _value = value;
        _key = key;
    }

    public function get value():int {
        return _value;
    }

    public function get key():String {
        return _key;
    }

    public static function byValue(value:int):Direction {
        switch (value) {
            case 0:
                return NONE;
            case 1:
                return LEFT;
            case 2:
                return RIGHT;
            case 3:
                return UP;
            case 4:
                return DOWN;
        }
        throw new ArgumentError("Invalid direction value");
    }
}
}