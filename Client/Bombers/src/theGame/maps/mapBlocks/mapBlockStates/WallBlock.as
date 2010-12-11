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
import theGame.model.explosionss.ExplosionType;

public class WallBlock implements IMapBlockState {
    public function WallBlock() {
    }

    private var _isExplodingNow:Boolean = false;

    public function get isExplodingNow():Boolean {
        return _isExplodingNow;
    }

    public function explodesAndStopsExplosion():Boolean {
        return false;
    }

    public function get type():MapBlockType {
        return MapBlockType.WALL;
    }

    public function canGoThrough():Boolean {
        return false;
    }

    public function canSetBomb():Boolean {
        return false;
    }

    public function canExplosionGoThrough():Boolean {
        return false;
    }

    public function typeAfterExplosion(expl:IExplosion):MapBlockType {
        if(expl.type == ExplosionType.ATOM)
             return MapBlockType.FREE;
        return MapBlockType.WALL;
    }

    public function explode(expl:IExplosion):void {
        //do nothing, this is a wall dude
        // atom explosion makes it free so do nothing either
    }

    public function stopExplosion():void {
    }

    public function get hiddenObject():IMapObject {
        return NullMapObject.getInstance();
    }

     public function get canShowObjects():Boolean {
        return false;
    }

    public function set hiddenObject(value:IMapObject):void  {
    }
}
}