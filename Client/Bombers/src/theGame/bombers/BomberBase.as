/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers {
import com.greensock.TweenMax;

import org.osflash.signals.Signal;

import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.interfaces.IGameSkin;
import theGame.bombers.interfaces.IMapCoords;
import theGame.bombers.mapInfo.MapCoords;
import theGame.bombers.skin.BomberSkin;
import theGame.bombers.skin.GameSkin;
import theGame.bombss.BombsBuilder;
import theGame.data.Consts;
import theGame.games.IGame;
import theGame.maps.IMap;
import theGame.model.signals.StateAddedSignal;
import theGame.model.signals.StateRemovedSignal;
import theGame.playerColors.PlayerColor;
import theGame.utils.ViewState;
import theGame.weapons.IWeapon;

public class BomberBase {

    protected var game:IGame;
    protected var _playerId:int;
    protected var _bombBuilder:BombsBuilder;

    protected var _map:IMap;
    protected var _skills:IGameSkills;
    protected var _coords:IMapCoords;
    protected var _gameSkin:IGameSkin;
    protected var _color:PlayerColor;
    protected var _life:int;
    protected var _weapon:IWeapon;

    private var _isImmortal:Boolean;

    private var _becameUntouchable:Signal = new Signal();
    private var _lostUntouchable:Signal = new Signal();

    private var _stateAdded:StateAddedSignal = new StateAddedSignal();
    private var _stateRemoved:StateRemovedSignal = new StateRemovedSignal();

    public function BomberBase(game:IGame, playerId:int, userName:String, color:PlayerColor, skills:IGameSkills, weapon:IWeapon, skin:BomberSkin, bombBuilder:BombsBuilder) {
        this.game = game;
        _playerId = playerId;
        _bombBuilder = bombBuilder;
        _skills = skills;
        _gameSkin = new GameSkin(skin, color);
        _color = color;
        _weapon = weapon;
        _userName = userName;

        _life = skills.startLife;
    }

    protected var _userName:String;

    public function makeImmortalFor(secs:Number, blink:Boolean = true):void {
        if (isDead || isImmortal)
            return;
        _isImmortal = true;
        if (blink) {
            stateAdded.dispatch(new ViewState(ViewState.BLINKING, {}, TweenMax.fromTo(new Object(), Consts.BLINKING_TIME, {alpha:0}, {alpha:ViewState.GET_DEFAULT_VALUE, repeat:-1,yoyo:true,paused:true,data:{alpha:ViewState.GET_DEFAULT_VALUE}})))
        }
        TweenMax.delayedCall(secs, function():void {
            _isImmortal = false;
            if (blink)
                stateRemoved.dispatch(ViewState.BLINKING);
        })
        becameUntouchable.dispatch();
    }

    public function putOnMap(map:IMap, x:int, y:int):void {
        _map = map;
        _coords = new MapCoords(map, x, y, 0, 0);
    }

    public function get userName():String {
        return _userName;
    }

    public function get playerId():int {
        return _playerId;
    }

    public function get gameSkills():IGameSkills {
        return _skills;
    }

    public function get weapon():IWeapon {
        return _weapon;
    }

    public function get life():int {
        return _life;
    }

    public function get gameSkin():IGameSkin {
        return _gameSkin;
    }

    public function get coords():IMapCoords {
        return _coords;
    }

    public function get isImmortal():Boolean {
        return _isImmortal;
    }

    public function get becameUntouchable():Signal {
        return _becameUntouchable;
    }

    public function get lostUntouchable():Signal {
        return _lostUntouchable;
    }

    public function get color():PlayerColor {
        return _color;
    }

    public function set life(life:int):void {
        _life = life;
    }

    public function get isDead():Boolean {
        return _life <= 0;
    }

    public function get stateAdded():StateAddedSignal {
        return _stateAdded;
    }

    public function get stateRemoved():StateRemovedSignal {
        return _stateRemoved;
    }
}
}