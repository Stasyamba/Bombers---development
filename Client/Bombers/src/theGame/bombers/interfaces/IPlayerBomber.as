/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.interfaces {
import theGame.bombss.BombType;
import theGame.maps.interfaces.IBonus;
import theGame.utils.Direction;

public interface IPlayerBomber extends IBomber {
    function addDirection(dir:Direction):void;

    function removeDirection(dir:Direction):void;

    function setBomb(bombType:BombType):void;

    function tryTakeBonus(bonus:IBonus):void;


    function tryUseWeapon():void;
}
}