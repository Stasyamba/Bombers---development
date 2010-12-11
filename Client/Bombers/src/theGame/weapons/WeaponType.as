/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.weapons {
public class WeaponType {

    public static const ATOM_BOMB_WEAPON:WeaponType = new WeaponType(1, "ATOM_BOMB_WEAPON");
    public static const NULL:WeaponType = new WeaponType(-1, "NULL");
    public static const HAMELEON:WeaponType = new WeaponType(2, "HAMELEON_WEAPON");

    private var _value:int;
    private var _key:String;

    public function WeaponType(value:int, key:String) {
        _value = value;
        _key = key;
    }

    public function get value():int {
        return _value;
    }

    public function get key():String {
        return _key;
    }
}
}