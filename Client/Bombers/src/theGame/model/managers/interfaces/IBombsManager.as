/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.interfaces {
import theGame.bombss.interfaces.IBomb;

public interface IBombsManager {

    function addBombAt(x:int, y:int, bomb:IBomb):void;

    function getBombAt(x:int, y:int):IBomb;

    /*
     * check if any bombs exploded within elapsed time
     * for singleplayer
     * */
    function checkBombs(elapsedMiliSecs:int):void;

    /*
     * manual explosion (bomb added to readyToExplode list)
     * for multiplayer
     * */
    function explodeBombAt(x:int, y:int, power:int = -1):void;

    function get pulseOffset():Number;

    function get pulseScale():Number;

    function get fastOffset():Number;

    function get fastScale():Number;
}
}