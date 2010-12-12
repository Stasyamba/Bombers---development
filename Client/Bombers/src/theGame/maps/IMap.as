/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps {
import mx.collections.ArrayList;

import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IMapBlock;
import theGame.utils.Direction;

public interface IMap {
    function get blocks():Vector.<IMapBlock>;

    function get bigObjects():Vector.<IBigObject>;

    function getBlock(x:uint, y:uint):IMapBlock;

    function get width():uint;

    function get height():uint;

    /*
     * returns a neighbour to direction @to of the block at coords (@ofX,@ofY)
     * if such block doesn't exist, returns NullMapBlock instance  
     * */
    function getNeighbour(ofX:int, ofY:int, to:Direction):IMapBlock;

    /*
     * Array of player spawns. spawn is a dynamic object with fields 'x' and 'y' -- coordinates of the spawn block
     * */
    function get spawns():Array;

    function validPoint(x:int, y:int):Boolean;

    function get explosionPrints():ArrayList;
}
}