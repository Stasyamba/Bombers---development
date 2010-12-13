/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks {
import org.osflash.signals.Signal;

import theGame.bombss.BombType;
import theGame.bombss.NullBomb;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.builders.MapBlockStateBuilder;
import theGame.maps.builders.MapObjectBuilder;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.mapObjects.NullMapObject;
import theGame.model.explosionss.ExplosionType;

//builders are injected after creation
public class MapBlock extends MapBlockBase implements IMapBlock {


    private var _mapBlockStateBuilder:MapBlockStateBuilder;
    private var _mapObjectBuilder:MapObjectBuilder;


    private var _object:IMapObject;
    private var _bomb:IBomb;

    private var _isExplodingNow:Boolean = false;

    private var _objectCollected:Signal = new Signal(Boolean);

    private var _explodedBy:ExplosionType;
    private var _hasExplosionPrint:Boolean = false;

    public function get isExplodingNow():Boolean {
        return _isExplodingNow;
    }


    public function canSetBomb():Boolean {
        if (bomb.type == BombType.NULL)
            return state.canSetBomb();
        return false;
    }

    public function canGoThrough():Boolean {
        if (_bomb.canGoThrough() && object.canGoThrough())
            return state.canGoThrough();
        return false;
    }

    public function canExplosionGoThrough():Boolean {
        if (!object.canExplosionGoThrough())
            return false;
        return state.canExplosionGoThrough();
    }

    public function explodesAndStopsExplosion():Boolean {
        if (object.explodesAndStopsExplosion())
            return true;
        return state.explodesAndStopsExplosion();
    }

    public function canHaveExplosionPrint(explType:ExplosionType):Boolean {
        return state.canHaveExplosionPrint(explType);
    }

    private function checkExplosionPrint(expl:IExplosion):void {
        if (expl.type.printsEverywhere || (expl.centerX == x && expl.centerY == y)) {
            if (state.canHaveExplosionPrint(expl.type)) {
                _hasExplosionPrint = true;
                _explodedBy = expl.type
            }
        }
    }

    public function explode(expl:IExplosion):void {

        checkExplosionPrint(expl);

        if (isExplodingNow) return;
        if (_state.stateAfterExplosion(expl) != _state.type) {
            explosionStopped.addOnce(function():void {
                if (_state.stateAfterExplosion(expl) == MapBlockType.FREE)
                    _object = _state.hiddenObject;
                _state = _mapBlockStateBuilder.make(_state.stateAfterExplosion(expl));
            });
        }
        else
            state.explode(expl);

        _isExplodingNow = true;
        explosionStarted.dispatch();
    }

    public function stopExplosion():void {
        _isExplodingNow = false;
        explosionStopped.dispatch();
        viewUpdated.dispatch();
    }

    public function setState(state:IMapBlockState):void {
        _state = state;
        viewUpdated.dispatch();
    }

    /*
     * use mapblock builder instead
     * */
    function MapBlock(x:int, y:int, block:IMapBlockState, mapBlockStateBuilder:MapBlockStateBuilder, mapObjectBuilder:MapObjectBuilder) {
        _x = x;
        _y = y;
        _state = block;
        _mapBlockStateBuilder = mapBlockStateBuilder;
        _mapObjectBuilder = mapObjectBuilder;

        _object = NullMapObject.getInstance();
        _bomb = NullBomb.getInstance();
    }


    public function collectObject(byMe:Boolean):void {
        objectCollected.dispatch(byMe)
        viewUpdated.dispatch();
        _object = NullMapObject.getInstance();
    }

    public function clearBomb():void {
        _bomb = NullBomb.getInstance();
        viewUpdated.dispatch();
    }

    public function setBomb(bomb:IBomb):void {
        _bomb = bomb;
        _viewUpdated.dispatch();
    }

    public function setObject(object:IMapObject):void {
        if (state.canShowObjects) {
            _object = object;
            viewUpdated.dispatch();
        } else {
            state.hiddenObject = object;
        }
    }

    public function setDieWall():void {
        _state = _mapBlockStateBuilder.make(MapBlockType.WALL)
        if (_state.type != MapBlockType.WALL)
            trace("WTF???")
        viewUpdated.dispatch();
    }

    //getters
    public function get hasExplosionPrint():Boolean {
        return _explodedBy;
    }


    public function get object():IMapObject {
        return _object;
    }


    public function stateAfterExplosion(expl:IExplosion):MapBlockType {
        return state.stateAfterExplosion(expl);
    }

    public function get bomb():IBomb {
        return _bomb;
    }

    public function get objectCollected():Signal {
        return _objectCollected;
    }

    public function get hiddenObject():IMapObject {
        return state.hiddenObject;
    }

    public function set hiddenObject(value:IMapObject):void {
        state.hiddenObject = value;
    }

    public function get canShowObjects():Boolean {
        return state.canShowObjects;
    }

    public function get explodedBy():ExplosionType {
        return _explodedBy;
    }


}
}