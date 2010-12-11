/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.mapBlockStates {
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.maps.mapObjects.NullMapObject;

public class FreeBlock implements IMapBlockState {

    public function FreeBlock() {
    }

    private var _isExplodingNow:Boolean = false;

    public function get isExplodingNow():Boolean {
        return _isExplodingNow;
    }

    public function canGoThrough():Boolean {
        return true;
    }

    public function canSetBomb():Boolean {
        return true;
    }

    public function canExplosionGoThrough():Boolean {
        return true;
    }

    public function typeAfterExplosion(expl:IExplosion):MapBlockType {
        return MapBlockType.FREE;
    }

    public function explodesAndStopsExplosion():Boolean {
        return false;
    }

    public function explode(expl:IExplosion):void {
        //do nothing: nothing to explode
    }

    public function get type():MapBlockType {
        return MapBlockType.FREE;
    }

    public function stopExplosion():void {
    }

    public function get hiddenObject():IMapObject {
        return NullMapObject.getInstance();
    }
    public function set hiddenObject(value:IMapObject):void  {
    }

    public function get canShowObjects():Boolean {
        return true;
    }
}
}