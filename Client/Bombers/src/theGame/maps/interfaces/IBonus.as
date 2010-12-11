/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import theGame.bombers.interfaces.IBomber;
import theGame.maps.mapObjects.bonuses.BonusType;
import theGame.maps.mapObjects.MapObjectType;

public interface IBonus extends IMapObject {
    function activateOn(player:IBomber):void;

    function tryToTake():void;

    function get wasTriedToBeTaken():Boolean;
}
}