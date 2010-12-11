/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
public interface IBigObject {


    function get elemX():int;

    function get elemY():int;

    function get life():int;

    function get description():IBigObjectDescription;
}
}