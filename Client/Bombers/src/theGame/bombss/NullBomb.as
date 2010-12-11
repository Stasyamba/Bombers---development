/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss {
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.NullExplosion;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapBlocks.NullMapBlock;

public class NullBomb implements IBomb {

    private static var instance:NullBomb;

    public static function getInstance():NullBomb {
        if (instance == null)
            instance = new NullBomb();
        return instance;
    }

    function NullBomb() {
    }

    public function onSet():void {
    }

    public function explode():IExplosion {
        trace("SHIT, null bomb explode call")
        return NullExplosion.getInstance();
    }

    public function get exploded():Boolean {
        return false;
    }

    public function get timeToExplode():int {
        return 0;
    }

    public function onTimeElapsed(elapsedSecs:Number):void {
    }

    public function get block():IMapBlock {
        trace("SHIT, null bomb block requested")
        return NullMapBlock.getInstance();
    }

    public function get type():BombType {
        return BombType.NULL;
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

    public function get power():int {
        return -1;
    }

    public function set power(value:int):void {
    }

    public function get owner():IBomber {
        return null;
    }
}
}