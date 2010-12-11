/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks {
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

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

//builders are injected after creation
public class MapBlock extends MapBlockBase implements IMapBlock {


    private var _mapBlockStateBuilder:MapBlockStateBuilder;
    private var _mapObjectBuilder:MapObjectBuilder;


    private var _object:IMapObject;
    private var _bomb:IBomb;

    private var _isExploded:Boolean = false;

    private var _isExplodingNow:Boolean = false;
    private var _objectCollected:Signal = new Signal(Boolean);

    public function get isExplodingNow():Boolean {
        return _isExplodingNow;
    }


    public function canSetBomb():Boolean {
        //todo:add check bigObject
        if (bomb.type == BombType.NULL)
            return state.canSetBomb();
        return false;
    }

    public function canGoThrough():Boolean {
        //todo:add check bigObject
        if (_bomb.canGoThrough() && object.canGoThrough())
            return state.canGoThrough();
        return false;
    }

    public function canExplosionGoThrough():Boolean {
        //todo:add check bigObject
        if (!object.canExplosionGoThrough())
            return false;
        return state.canExplosionGoThrough();
    }

    public function explodesAndStopsExplosion():Boolean {
        //todo:add check bigObject
        if (object.explodesAndStopsExplosion())
            return true;
        return state.explodesAndStopsExplosion();
    }

    public function explode(expl:IExplosion):void {
        //todo:add big object check
        if (_state.typeAfterExplosion(expl) != _state.type) {
            explosionStopped.addOnce(function():void {
                if (_state.typeAfterExplosion(expl) == MapBlockType.FREE)
                    _object = _state.hiddenObject;
                _state = _mapBlockStateBuilder.make(_state.typeAfterExplosion(expl));
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

    /*
     * use mapblock builder instead
     * */
    function MapBlock(x:int, y:int, block:IMapBlockState, mapBlockTypeBuilder:MapBlockStateBuilder, mapObjectBuilder:MapObjectBuilder) {
        _x = x;
        _y = y;
        _state = block;
        _mapBlockStateBuilder = mapBlockTypeBuilder;
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
        _isExploded = true;
        viewUpdated.dispatch();
    }


    public function get isExploded():Boolean {
        return _isExploded;
    }

    public function get object():IMapObject {
        return _object;
    }


    public function typeAfterExplosion(expl:IExplosion):MapBlockType {
        return state.typeAfterExplosion(expl);
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

    public function get bomb():IBomb {
        return _bomb;
    }

    public function get objectCollected():Signal {
        return _objectCollected;
    }

    public function get hiddenObject():IMapObject {
        return state.hiddenObject;
    }

    public function set hiddenObject(value:IMapObject):void  {
        state.hiddenObject = value;
    }

    public function get canShowObjects():Boolean {
        return state.canShowObjects;
    }

    public function setDieWall():void {
       // _object = NullMapObject.getInstance();
        _state = _mapBlockStateBuilder.make(MapBlockType.WALL)
        if(_state.type != MapBlockType.WALL)
            trace ("WTF???")
        viewUpdated.dispatch();
    }
}
}