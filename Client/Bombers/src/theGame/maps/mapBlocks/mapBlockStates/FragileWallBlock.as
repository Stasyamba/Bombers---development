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

public class FragileWallBlock implements IMapBlockState {

    public function FragileWallBlock(lifePoints:int = 1) {
        this.lifePoints = lifePoints;
    }

    public var lifePoints:int;

    private var _hiddenObject:IMapObject = NullMapObject.getInstance();

    public function canSetBomb():Boolean {
        return false;
    }

    public function stateAfterExplosion(expl:IExplosion):MapBlockType {
        return lifePoints > 1 ? MapBlockType.FRAGILE_WALL : MapBlockType.FREE;
    }

    public function canGoThrough():Boolean {
        return false;
    }

    public function canExplosionGoThrough():Boolean {
        return true;
    }

    public function explodesAndStopsExplosion():Boolean {
        return true;
    }

    public function explode(expl:IExplosion):void {
        throw new Error("Implement fragile walls exploding")
    }

    public function get type():MapBlockType {
        return MapBlockType.FRAGILE_WALL;
    }

    public function get canShowObjects():Boolean {
        return false;
    }

    public function canHaveExplosionPrint(explType:ExplosionType):Boolean {
        return lifePoints > 1;
    }

    public function get hiddenObject():IMapObject {
        return _hiddenObject;
    }

    public function set hiddenObject(value:IMapObject):void {
        _hiddenObject = value;
    }
}
}