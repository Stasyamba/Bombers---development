/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import theGame.bombers.interfaces.IBomber;

public interface IBonus extends IMapObject {
    function activateOn(player:IBomber):void;

    function tryToTake():void;

    function get wasTriedToBeTaken():Boolean;
}
}