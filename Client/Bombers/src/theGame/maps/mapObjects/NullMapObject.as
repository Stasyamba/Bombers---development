/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects {
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.interfaces.IMapObjectType;
import theGame.maps.mapBlocks.NullMapBlock;

public class NullMapObject implements IMapObject {

    private static var instance:NullMapObject;

    public static function getInstance():NullMapObject {
        if (instance == null)
            instance = new NullMapObject();
        return instance;
    }

    function NullMapObject() {
    }

    public function canExplosionGoThrough():Boolean {
        return true;
    }

    public function canGoThrough():Boolean {
        return true;
    }

    public function explodesAndStopsExplosion():Boolean {
        return false;
    }

    public function get type():IMapObjectType {
        return MapObjectType.NULL;
    }

    public function get x():int {
        return -1;
    }

    public function get y():int {
        return -1;
    }

    public function get block():IMapBlock {
        return NullMapBlock.getInstance();
    }
}
}