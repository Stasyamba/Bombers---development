/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects {
import theGame.maps.interfaces.IMapObjectType;

public class MapObjectType implements IMapObjectType{


    public static const NULL:MapObjectType = new MapObjectType(0, "NULL");

    private var _value:int;
    private var _key:String;

    public function get value():int {
        return _value;
    }

    public function get key():String {
        return _key;
    }

    public function MapObjectType(value:int, key:String) {
        _value = value;
        _key = key;
    }

    public static function byValue(value:int):MapObjectType {
        switch (value) {
            case 0: return NULL;
        }
        throw new ArgumentError("bad value")
    }
}
}