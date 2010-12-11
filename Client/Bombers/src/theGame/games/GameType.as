/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
public class GameType {


    public static const REGULAR:GameType = new GameType("REGULAR",4,2,'bombers','com.vensella.bombers.BombersGameProcess',true)
    public static const SINGLE:GameType = new GameType("SINGLE",1,1,'','',false)

    private var _value:String;
    private var _maxPlayers:int;
    private var _minPlayers:int;
    private var _extensionId:String;
    private var _extensionClassName:String;
    private var _isMultiplayer:Boolean;


    public function GameType(value:String, maxPlayers:int, minPlayers:int, extensionId:String, extensionClassName:String, isMultiplayer:Boolean) {
        _value = value;
        _maxPlayers = maxPlayers;
        _minPlayers = minPlayers;
        _extensionId = extensionId;
        _extensionClassName = extensionClassName;
        _isMultiplayer = isMultiplayer;
    }

    public function get value():String {
        return _value;
    }

    public function get maxPlayers():int {
        return _maxPlayers;
    }

    public function get minPlayers():int {
        return _minPlayers;
    }

    public function get extensionId():String {
        return _extensionId;
    }

    public function get extensionClassName():String {
        return _extensionClassName;
    }

    public function get isMultiplayer():Boolean {
        return _isMultiplayer;
    }

    public static function fromValue(value:String):GameType {
        switch(value){
            case "REGULAR": return REGULAR;
            case "SINGLE": return SINGLE;
        }
        throw new ArgumentError("invalid game type")
    }
}
}