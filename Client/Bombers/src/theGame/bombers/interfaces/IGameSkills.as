/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.interfaces {
public interface IGameSkills {
    function get bombCount():int;

    function set bombCount(value:int):void;

    function get bombPower():int;

    function set bombPower(bombPower:int):void;

    function get speed():Number;

    function set speed(speed:Number):void;

    function get startLife():int;

    function get immortalTime():Number;
}
}