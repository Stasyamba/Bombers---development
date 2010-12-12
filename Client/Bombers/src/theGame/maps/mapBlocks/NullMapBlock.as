/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks {
import org.osflash.signals.Signal;

import theGame.bombss.NullBomb;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.mapObjects.NullMapObject;
import theGame.model.explosionss.ExplosionType;

/*
 * NullMapBlock is to avoid null checks
 * */
public class NullMapBlock extends MapBlockBase implements IMapBlock {


    private static var instance:NullMapBlock;

    public function stopExplosion():void {
    }

    public function get objectCollected():Signal {
        return null;
    }

    public static function getInstance():NullMapBlock {
        if (instance == null)
            instance = new NullMapBlock();
        return instance;
    }


    public override function get x():int {
        return -1;
    }

    public override function get y():int {
        return -1;
    }

    public function get isExplodingNow():Boolean {
        return false;
    }

    public function get explodedBy():ExplosionType {
        return ExplosionType.NULL;
    }

    public function canHaveExplosionPrint(explType:ExplosionType):Boolean {
        return false;
    }

    public function collectObject(byMe:Boolean):void {
    }

    public override function get state():IMapBlockState {
        return null;
    }

    public function get hasExplosionPrint():Boolean {
        return false;
    }

    public function get explodedWith():Class {
        return null;
    }

    public function explodesAndStopsExplosion():Boolean {
        return false;
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

    public function explode(expl:IExplosion):void {
    }

    public function stateAfterExplosion(expl:IExplosion):MapBlockType {
        return MapBlockType.NULL;
    }

    public function get object():IMapObject {
        return NullMapObject.getInstance();
    }

    public function setBomb(bomb:IBomb):void {
    }

    public override function get type():MapBlockType {
        return MapBlockType.NULL;
    }

    public function get bomb():IBomb {
        return NullBomb.getInstance();
    }

    public function clearBomb():void {
    }

    public function NullMapBlock() {
    }

    public function setObject(object:IMapObject):void {
    }

    public function get canShowObjects():Boolean {
        return false;
    }

    public function set hiddenObject(value:IMapObject):void {
    }

    public function get hiddenObject():IMapObject {
        return NullMapObject.getInstance();
    }

    public function setDieWall():void {
        trace("SHIIIIIT");
    }
}
}