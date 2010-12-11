/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import org.osflash.signals.Signal;

import theGame.bombss.interfaces.IBomb;

//add signals
public interface IMapBlock extends IMapBlockState {

    function collectObject(byMe:Boolean):void;

    function get state():IMapBlockState

    function get bomb():IBomb;

    function get object():IMapObject;

    function setBomb(bomb:IBomb):void;

    function get isExploded():Boolean;

    function get viewUpdated():Signal;

    function get x():int;

    function get y():int;

    function clearBomb():void;

    function get isExplodingNow():Boolean;

    function stopExplosion():void;

    function get explosionStarted():Signal;

    function get explosionStopped():Signal;

    function setObject(object:IMapObject):void;

    function setDieWall():void;

    function get objectCollected():Signal;
}
}