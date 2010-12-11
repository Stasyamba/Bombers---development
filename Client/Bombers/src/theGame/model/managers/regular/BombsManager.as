/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.regular {
import mx.collections.ArrayList;

import theGame.bombss.interfaces.IBomb;
import theGame.data.Consts;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.managers.interfaces.IBombsManager;
import theGame.model.managers.interfaces.IMapManager;

public class BombsManager implements IBombsManager {

    protected var _bombs:ArrayList = new ArrayList();
    protected var _mapManager:IMapManager;

    protected var readyToExplode:ArrayList = new ArrayList();
    protected var timeSinceLastExplosion:Number = 0;
    protected static const EXPLOSION_PERIOD:Number = 0.80;

    private static const UP:int = 1;
    private static const DOWN:int = -1;

    private var pulseMaxSize:Number = Consts.BLOCK_SIZE;
    private var pulseSize:Number = Consts.BLOCK_SIZE;
    private var pulseMinSize:Number = Consts.BLOCK_SIZE - 4;

    private var pulsingSpeed:Number;
    private var pulsingDir:int;

    private var fastPulsingSpeed:Number;
    private var fastPulseSize:Number = Consts.BLOCK_SIZE;
    private var fastPulsingDir:int;


    public function BombsManager(mapManager:IMapManager) {
        _mapManager = mapManager;
        Context.gameModel.frameEntered.add(onPulse);
        startPulsing();
    }

    public function addBombAt(x:int, y:int, bomb:IBomb):void {
        var block:IMapBlock = _mapManager.map.getBlock(x, y);
        block.setBomb(bomb);
        _bombs.addItem(bomb);
    }

    public function getBombAt(x:int, y:int):IBomb {
        var block:IMapBlock = _mapManager.map.getBlock(x, y);
        return block.bomb;
    }

    public function checkBombs(elapsedMiliSecs:int):void {
        // do nothing, bombs are exploded manually, by server events
        var elapsedSecs:Number = elapsedMiliSecs / 1000;
        for each (var bomb:IBomb in _bombs.source) {
            bomb.onTimeElapsed(elapsedSecs);
        }
        checkBuffer(elapsedSecs);
    }

    public function explodeBombAt(x:int, y:int, power_bonus:int = 0):void {
        trace("bomb exploded at " + x + "," + y);
        var b:IBomb = getBombAt(x, y);
        b.power += power_bonus;
        _bombs.removeItem(b);
        readyToExplode.addItem(b);
    }

    protected function checkBuffer(elapsedSecs:Number):void {
        timeSinceLastExplosion += elapsedSecs;
        if (timeSinceLastExplosion >= EXPLOSION_PERIOD) {
            timeSinceLastExplosion -= EXPLOSION_PERIOD;
            if (readyToExplode.length > 0) {
                var expls:ArrayList = new ArrayList();
                for each (var b:IBomb in readyToExplode.source) {
                    expls.addItem(b.explode());
                    b.block.clearBomb();
                }
                readyToExplode.removeAll();
                Context.game.explosionsAdded.dispatch(expls);
            }
        }
    }

    private function startPulsing():void {
        pulsingDir = fastPulsingDir = DOWN;
        pulsingSpeed = 15;
        fastPulsingSpeed = 50;
        pulseSize = fastPulseSize = pulseMaxSize;
    }

    private function onPulse(elapsedMilliSecs:int):void {
        pulseSize += pulsingDir * pulsingSpeed * elapsedMilliSecs / 1000;
        if (pulseSize <= pulseMinSize || pulseSize >= pulseMaxSize) {
            pulsingDir = -pulsingDir;
            pulseSize = pulseSize <= pulseMinSize ? pulseMinSize : pulseMaxSize;
        }

        fastPulseSize += fastPulsingDir * fastPulsingSpeed * elapsedMilliSecs / 1000;
        if (fastPulseSize <= pulseMinSize || fastPulseSize >= pulseMaxSize) {
            fastPulsingDir = -fastPulsingDir;
            fastPulseSize = fastPulseSize <= pulseMinSize ? pulseMinSize : pulseMaxSize;
        }
    }

    public function get pulseOffset():Number {
        return (pulseMaxSize - pulseSize) / 2;
    }

    public function get pulseScale():Number {
        return pulseSize / pulseMaxSize;
    }

    public function get fastOffset():Number {
        return (pulseMaxSize - fastPulseSize) / 2;
    }

    public function get fastScale():Number {
        return fastPulseSize / pulseMaxSize;
    }
}
}