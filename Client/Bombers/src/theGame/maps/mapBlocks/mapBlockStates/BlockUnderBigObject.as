/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.mapBlockStates {
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.interfaces.IMapObjectType;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.maps.mapObjects.NullMapObject;
import theGame.model.explosionss.ExplosionType;

public class BlockUnderBigObject implements IMapBlockState {

    private var _explodesAndStopsExplosion:Boolean;
    private var _canGoThrough:Boolean;
    private var _canSetBomb:Boolean;
    private var _canExplosionGoThrough:Boolean;
    private var _typeAfterObjectDestroyed:MapBlockType;
    private var _objectAfterObjectDestroyed:IMapObjectType;

    private var objectUnder:IBigObject;
    private var _explodes:Boolean;

    public function explodesAndStopsExplosion():Boolean {
        return _explodesAndStopsExplosion;
    }

    public function canGoThrough():Boolean {
        return _canGoThrough;
    }

    public function canSetBomb():Boolean {
        return _canSetBomb;
    }

    public function canExplosionGoThrough():Boolean {
        return _canExplosionGoThrough;
    }

    public function canHaveExplosionPrint(explType:ExplosionType):Boolean {
        return false;
    }

    public function explode(expl:IExplosion):void {
        if (_explodes)
            objectUnder.explode(expl);
    }

    public function get type():MapBlockType {
        return MapBlockType.UNDER_BIG_OBJECT;
    }

    public function stateAfterExplosion(expl:IExplosion):MapBlockType {
        return MapBlockType.UNDER_BIG_OBJECT;
    }

    public function get canShowObjects():Boolean {
        return false;
    }

    public function get hiddenObject():IMapObject {
        return NullMapObject.getInstance();
    }

    public function set hiddenObject(value:IMapObject):void {

    }

    public function BlockUnderBigObject(explodesAndStopsExplosion:Boolean, canGoThrough:Boolean, canSetBomb:Boolean, canExplosionGoThrough:Boolean, typeAfterObjectDestroyed:MapBlockType, objectAfterObjectDestroyed:IMapObjectType, explodes:Boolean, objectUnder:IBigObject) {
        _explodesAndStopsExplosion = explodesAndStopsExplosion;
        _canGoThrough = canGoThrough;
        _canSetBomb = canSetBomb;
        _canExplosionGoThrough = canExplosionGoThrough;
        _explodes = explodes;
        _typeAfterObjectDestroyed = typeAfterObjectDestroyed;
        _objectAfterObjectDestroyed = objectAfterObjectDestroyed;
        this.objectUnder = objectUnder;
    }

    public function get typeAfterObjectDestroyed():MapBlockType {
        return _typeAfterObjectDestroyed;
    }

    public function get objectAfterObjectDestroyed():IMapObjectType {
        return _objectAfterObjectDestroyed;
    }

}
}
