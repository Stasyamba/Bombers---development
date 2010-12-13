/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks {
public class MapBlockType {

    public static const NULL:MapBlockType = new MapBlockType("NULL");
    public static const FREE:MapBlockType = new MapBlockType("FREE");
    public static const BOX:MapBlockType = new MapBlockType("BOX");
    public static const WALL:MapBlockType = new MapBlockType("WALL");
    public static const DEATH_WALL:MapBlockType = new MapBlockType("DEATH_WALL");
    public static const FRAGILE_WALL:MapBlockType = new MapBlockType("FRAGILE_WALL");
    public static const UNDER_BIG_OBJECT:MapBlockType = new MapBlockType("UNDER_BIG_OBJECT");

    private static const f:uint = 0x66;
    private static const b:uint = 0x62;
    private static const w:uint = 0x77;
    private static const d:uint = 0x64;
    private static const u:uint = 0x75;

    private var _key:String;

    public function MapBlockType(value:String) {
        _key = value;
    }

    public function get key():String {
        return _key;
    }

    public static function byKey(key:String):MapBlockType {
        switch (key) {
            case "NULL":return NULL;
            case "FREE":return FREE;
            case "BOX":return BOX;
            case "WALL":return WALL;
            case "FRAGILE_WALL":return FRAGILE_WALL;
            case "UNDER_BIG_OBJECT":return UNDER_BIG_OBJECT;
            case "DEATH_WALL":return DEATH_WALL;
        }
        throw new ArgumentError("invalid key value")
    }

    public static function fromChar(ch:uint):MapBlockType {
        switch (ch) {
            case f: return FREE;
            case w: return WALL;
            case b: return BOX;
            case d: return FRAGILE_WALL;
            case u: return UNDER_BIG_OBJECT;
        }
        throw new ArgumentError("InValid block type char");
    }
}
}