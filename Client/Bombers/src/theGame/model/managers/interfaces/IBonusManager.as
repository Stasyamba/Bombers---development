/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.interfaces {
import theGame.bombers.interfaces.IBomber;
import theGame.maps.interfaces.IBonus;

public interface IBonusManager {

    function addBonus(bonus:IBonus):void;

    function checkBonusTaken(elapsedMiliSecs:int):void;

    function takeBonus(x:int, y:int,player:IBomber):void;
}
}