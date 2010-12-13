/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import org.osflash.signals.Signal;

import theGame.bombss.interfaces.IBomb;
import theGame.model.explosionss.ExplosionType;

//add signals
public interface IMapBlock extends IMapBlockState {

    function get x():int;

    function get y():int;

    function get state():IMapBlockState

    function get bomb():IBomb;

    function get object():IMapObject;

    function setBomb(bomb:IBomb):void;

    function clearBomb():void;

    function setObject(object:IMapObject):void;

    function collectObject(byMe:Boolean):void;

    function get viewUpdated():Signal;

    function get hasExplosionPrint():Boolean;

    function get isExplodingNow():Boolean;

    function get explodedBy():ExplosionType;

    function get explosionStarted():Signal;

    function get explosionStopped():Signal;

    function stopExplosion():void;

    function setDieWall():void;

    function get objectCollected():Signal;

    function setState(state:IMapBlockState):void;
}
}