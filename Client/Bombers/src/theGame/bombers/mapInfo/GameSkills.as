/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.mapInfo {
import theGame.bombers.interfaces.IGameSkills;

public class GameSkills implements IGameSkills {

    private var _speed:Number;
    private var _bombCount:int;
    private var _bombPower:int;
    private var _startLife:int;
    private var _immortalTime:Number;


    public function GameSkills() {
        _speed = 100;
        _bombPower = 2;
        _bombCount = 3;
        _startLife = 3;
        _immortalTime = 3;
    }

    public function get bombCount():int {
        return _bombCount;
    }

    public function set bombCount(value:int):void {
        _bombCount = value;
    }

    public function get bombPower():int {
        return _bombPower;
    }

    public function set bombPower(bombPower:int):void {
        _bombPower = bombPower;
    }

    public function get speed():Number {
        return _speed;
    }

    public function set speed(speed:Number):void {
        _speed = speed;
    }

    public function get startLife():int {
        return _startLife;
    }

    public function get immortalTime():Number {
        return _immortalTime;
    }

}
}