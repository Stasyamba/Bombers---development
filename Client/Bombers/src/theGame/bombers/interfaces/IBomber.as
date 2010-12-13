/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.interfaces {
import org.osflash.signals.Signal;

import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.IMap;
import theGame.model.signals.StateAddedSignal;
import theGame.model.signals.StateRemovedSignal;
import theGame.playerColors.PlayerColor;
import theGame.weapons.IWeapon;

public interface IBomber {
    function get gameSkin():IGameSkin;

    function get playerId():int;

    function get userName():String;

    function get life():int;

    function putOnMap(map:IMap, x:int, y:int):void;

    function get coords():IMapCoords;

    function move(elapsedSeconds:Number):void;

    function get gameSkills():IGameSkills;

    /**
     *
     * @param expl
     * @return is player dead after explosion
     */
    function explode(expl:IExplosion = null):void;

    function get becameUntouchable():Signal;

    function get lostUntouchable():Signal;

    function get isImmortal():Boolean;

    function get color():PlayerColor;

    function set life(life:int):void;

    function get isDead():Boolean;

    function kill():void;

    function get stateAdded():StateAddedSignal

    function get stateRemoved():StateRemovedSignal;

    function useWeapon():void;

    function get weapon():IWeapon;
}
}