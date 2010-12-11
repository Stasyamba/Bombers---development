/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.mapBlockStates {
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.maps.mapBlocks.NullMapBlock;
import theGame.maps.mapObjects.NullMapObject;

public class BoxBlock implements IMapBlockState {

    private var _hiddenObject:IMapObject = NullMapObject.getInstance();

    public function BoxBlock() {
    }


    public function explodesAndStopsExplosion():Boolean {
        return true;
    }

    public function explode(expl:IExplosion):void {
        // do nothing 'cause type will change
    }

    public function typeAfterExplosion(expl:IExplosion):MapBlockType {
        return MapBlockType.FREE;
    }

    public function canGoThrough():Boolean {
        return false;
    }

    public function canSetBomb():Boolean {
        return false;
    }

    public function canExplosionGoThrough():Boolean {
        return true;
    }

    public function get type():MapBlockType {
        return MapBlockType.BOX;
    }

    public function stopExplosion():void {
    }

    public function get hiddenObject():IMapObject {
        return _hiddenObject;
    }

    public function get canShowObjects():Boolean {
        return false;
    }

    public function set hiddenObject(value:IMapObject):void {
        _hiddenObject = value;
    }
}
}