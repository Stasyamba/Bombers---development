/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.bots {
import theGame.bombers.interfaces.IMapCoords;
import theGame.utils.Direction;

public interface IWalkingStrategy {

    function getDirection(dir:Direction, _coords:IMapCoords):Direction;
}
}