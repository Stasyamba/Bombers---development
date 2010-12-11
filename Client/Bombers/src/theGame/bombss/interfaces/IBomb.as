/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss.interfaces {
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.BombType;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlock;

public interface IBomb {
    function canExplosionGoThrough():Boolean;

    function canGoThrough():Boolean;

    function explodesAndStopsExplosion():Boolean;

    function explode():IExplosion;

    function get exploded():Boolean;

    function get timeToExplode():int;

    function onTimeElapsed(elapsedSecs:Number):void;

    function get block():IMapBlock;

    function get type():BombType

    function get power():int;

    /*
     * to perform explosion with custom power
     * */
    function set power(value:int):void;

    function get owner():IBomber;


    function onSet():void;
}
}