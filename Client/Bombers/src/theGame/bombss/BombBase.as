/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss {
import theGame.bombers.interfaces.IBomber;
import theGame.explosionss.ExplosionsBuilder;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.managers.interfaces.IMapManager;

public class BombBase {


    public function BombBase( mapManager:IMapManager, explosionsBuilder:ExplosionsBuilder,block:IMapBlock, owner:IBomber) {
        _block = block;
        _owner = owner;
        _mapManager = mapManager;
        _explosionsBuilder = explosionsBuilder;
    }

    protected var _explodeTime:Number;
    protected var _block:IMapBlock;
    protected var _owner:IBomber;
    protected var _mapManager:IMapManager;
    protected var _explosionsBuilder:ExplosionsBuilder;

    public function canExplosionGoThrough():Boolean {
        return true;
    }

    public function canGoThrough():Boolean {
        return false;
    }

    public function explodesAndStopsExplosion():Boolean {
        return false;
    }

    public function onTimeElapsed(elapsedSecs:Number):void {
        _explodeTime -= elapsedSecs;
    }

    public function get timeToExplode():int {
        return _explodeTime;
    }

    public function get exploded():Boolean {
        return _explodeTime <= 0;
    }

    public function get owner():IBomber {
        return _owner;
    }

    public function get block():IMapBlock {
        return _block;
    }

}
}