/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss {
public class BombType {

    public static const NULL:BombType = new BombType(-1,"NULL",false);
    public static const REGULAR:BombType = new BombType(0,"REGULAR",true);
    public static const ATOM:BombType = new BombType(1,"ATOM",false);

    private var _value:int;
    private var _key:String;
    private var _needGlow:Boolean;


    function BombType(value:int, key:String, needGlow:Boolean) {
        _value = value;
        _key = key;
        _needGlow = needGlow;
    }

    public function get value():int {
        return _value;
    }

    public function get key():String {
        return _key;
    }

    public function get needGlow():Boolean {
        return _needGlow;
    }

    public static function byValue(value:int):BombType {
        switch (value) {
            case -1:
                return NULL;
            case 0:
                return REGULAR;
            case 1:
                return ATOM;
        }
        throw new ArgumentError("wrong bombType value");
    }
}
}