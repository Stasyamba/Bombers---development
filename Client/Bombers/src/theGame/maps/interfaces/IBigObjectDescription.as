/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
public interface IBigObjectDescription {

    function get id():String;

    function get width():int;

    function get height():int;

    function get defaultLife():int;

    function get blocks():Array;

    function get skin():String;
}
}