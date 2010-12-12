/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.explosionss {
public class ExplosionType {

    public static const REGULAR:ExplosionType = new ExplosionType("REGULAR", 1, false);
    public static const NULL:ExplosionType = new ExplosionType("NULL", 0, false);
    public static const COMPLEX:ExplosionType = new ExplosionType("COMPLEX", 0, false);
    public static const ATOM:ExplosionType = new ExplosionType("ATOM", 3, true);

    public static function byValue(value:String):ExplosionType {
        switch (value) {
            case "REGULAR":return REGULAR;
            case "NULL":return NULL;
            case "ATOM":return ATOM;
        }
        throw new ArgumentError("Invalid explosion type value");
    }

    private var _timeToLive:Number;
    private var _value:String;
    private var _printsEverywhere:Boolean;

    public function ExplosionType(value:String, timeToLive:Number, printsEverywhere:Boolean) {
        _timeToLive = timeToLive;
        _value = value;
        _printsEverywhere = printsEverywhere;
    }

    public function get value():String {
        return _value;
    }

    public function get timeToLive():Number {
        return _timeToLive;
    }

    public function get printsEverywhere():Boolean {
        return _printsEverywhere;
    }
}
}