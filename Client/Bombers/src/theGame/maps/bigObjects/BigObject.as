/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects {
import theGame.utils.greensock.TweenMax;

import org.osflash.signals.Signal;

import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.builders.MapBlockStateBuilder;
import theGame.maps.builders.MapObjectBuilder;
import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IBigObjectDescription;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.maps.mapBlocks.mapBlockStates.BlockUnderBigObject;
import theGame.maps.mapObjects.MapObjectType;

public class BigObject implements IBigObject {

    private var _mapBlockStateBuilder:MapBlockStateBuilder;
    private var _mapObjectBuilder:MapObjectBuilder;

    private var _x:int;
    private var _y:int;
    private var _life:int;
    private var _description:IBigObjectDescription;
    public var blocks:Vector.<IMapBlock>;

    private var _isExplodingNow:Boolean;

    private var _explosionStopped:Signal = new Signal();
    private var _explosionStarted:Signal = new Signal();
    private var _destroyed:Signal = new Signal();

    public function BigObject(x:int, y:int, description:IBigObjectDescription, blocks:Vector.<IMapBlock>, mapBlockStateBuilder:MapBlockStateBuilder, mapObjectBuilder:MapObjectBuilder, decoration:Boolean = false, life:int = -1) {
        _x = x;
        _y = y;
        _description = description;
        _life = life == -1 ? description.defaultLife : life;

        _mapBlockStateBuilder = mapBlockStateBuilder;
        _mapObjectBuilder = mapObjectBuilder;

        if (decoration) return;

        this.blocks = blocks;
        for (var i:int = 0; i < description.blocks.length; i++) {
            var obj:Object = description.blocks[i];
            var state:IMapBlockState = mapBlockStateBuilder.makeUnderObject(
                    obj.explodesAndStopsExplosion == "true",
                    obj.canGoThrough == "true",
                    obj.canExplosionGoThrough == "true",
                    obj.canSetBomb == "true",
                    MapBlockType.byKey(obj.typeAfterObjectDestroyed),
                    MapObjectType.byKey(obj.objectAfterObjectDestroyed),
                    obj.explodes == "true",
                    this);
            blocks[i].setState(state);
        }
    }

    public function get x():int {
        return _x;
    }

    public function get y():int {
        return _y;
    }

    public function get life():int {
        return _life;
    }

    public function get description():IBigObjectDescription {
        return _description;
    }

    public function get isDestroyed():Boolean {
        return life <= 0;
    }

    public function explode(expl:IExplosion):void {
        if (isDestroyed) return;
        if (!_isExplodingNow) {
            if (expl.damage >= life)
                destroy()
            else {
                _life -= expl.damage;
                startExplosion();
                TweenMax.delayedCall(3, function() {
                    stopExplosion();
                })
            }
        }
    }

    private function stopExplosion():void {
        _isExplodingNow = false;
        explosionStopped.dispatch()
    }

    private function startExplosion():void {
        _isExplodingNow = true;
        explosionStarted.dispatch()
    }

    public function destroy():void {
        _life = 0;
        for each (var block:IMapBlock in blocks) {
            if (block.type == MapBlockType.UNDER_BIG_OBJECT) {
                var oldState:BlockUnderBigObject = block.state as BlockUnderBigObject;
                block.setState(_mapBlockStateBuilder.make(oldState.typeAfterObjectDestroyed));
                block.setObject(_mapObjectBuilder.make(oldState.objectAfterObjectDestroyed, block));
            }
        }
        destroyed.dispatch();
    }

    public function get explosionStopped():Signal {
        return _explosionStopped;
    }

    public function get explosionStarted():Signal {
        return _explosionStarted;
    }

    public function get destroyed():Signal {
        return _destroyed;
    }
}
}