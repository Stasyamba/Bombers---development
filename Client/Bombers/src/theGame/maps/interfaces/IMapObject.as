/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import theGame.maps.mapObjects.MapObjectType;

public interface IMapObject {

    function canExplosionGoThrough():Boolean;

    function canGoThrough():Boolean;

    function explodesAndStopsExplosion():Boolean;

    function get x():int;

    function get y():int;

    function get block():IMapBlock;

    function get type():IMapObjectType;
}
}