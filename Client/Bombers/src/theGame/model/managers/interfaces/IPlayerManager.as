/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.interfaces {
import theGame.bombers.interfaces.IPlayerBomber;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IBonus;

public interface IPlayerManager {
    function get me():IPlayerBomber;

    function get myId():int;

    function setPlayer(player:IPlayerBomber):void;

    function movePlayer(elapsedMiliSecs:int):void;

    function checkPlayerMetExplosion(expl:IExplosion):void;

    function checkPlayerTakenBonus(bonus:IBonus):Boolean;

    function checkPlayerMetDieWall(x:int, y:int):Boolean;

    function killMe():void;
}
}