/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects {
import theGame.maps.interfaces.IMapObjectType;
import theGame.maps.mapObjects.bonuses.BonusType;

public class MapObjectType implements IMapObjectType {


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

    public static function byKey(key:String):IMapObjectType {
        switch (key) {
            case "NULL": return NULL;
            case BonusType.ADD_BOMB.key:return BonusType.ADD_BOMB;
            case BonusType.ADD_BOMB_POWER.key:return BonusType.ADD_BOMB_POWER;
            case BonusType.ADD_SPEED.key:return BonusType.ADD_SPEED;
            case BonusType.HEAL.key:return BonusType.HEAL;
        }
        throw new ArgumentError("bad value")
    }
}
}