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
    public static const FRAGILE_WALL:MapBlockType = new MapBlockType("FRAGILE_WALL");

    private static const f:uint = 0x66;
    private static const b:uint = 0x62;
    private static const w:uint = 0x77;
    private static const d:uint = 0x64;

    private var _value:String;

    public function MapBlockType(value:String) {
        _value = value;
    }

    public function get value():String {
        return _value;
    }

    public static function fromChar(ch:uint):MapBlockType {
        switch (ch) {
            case f: return FREE;
            case w: return WALL;
            case b: return BOX;
            case d: return FRAGILE_WALL;
        }
        throw new ArgumentError("InValid block type char");
    }
}
}