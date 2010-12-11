/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model {
import com.greensock.TweenMax;
import com.greensock.plugins.*;
import com.smartfoxserver.v2.entities.User;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.controls.Alert;

import theGame.games.GameBuilder;
import theGame.games.GameType;
import theGame.model.managers.ProfileManager;
import theGame.model.signals.FrameEnteredSignal;
import theGame.model.signals.GameEndedSignal;
import theGame.model.signals.GameReadySignal;
import theGame.model.signals.MapLoadedSignal;
import theGame.model.signals.ReadyToPlayAgainSignal;
import theGame.model.signals.manage.ReadyToCreateGameSignal;
import theGame.model.signals.manage.GameProfileLoadedSignal;
import theGame.model.signals.manage.GameStartedSignal;
import theGame.model.signals.manage.PlayerReadyChangedSignal;
import theGame.model.signals.manage.ThreeSecondsToStartSignal;
import theGame.profiles.GameProfile;

public class GameModel {

    //managers
    public var profileManager:ProfileManager;

    private var gameBuilder:GameBuilder = new GameBuilder();

    //---signals
    public var profileLoaded:GameProfileLoadedSignal = new GameProfileLoadedSignal();

    public var connectedToGame:ReadyToCreateGameSignal = new ReadyToCreateGameSignal();

    public var playerReadyChanged:PlayerReadyChangedSignal = new PlayerReadyChangedSignal();
    public var threeSecondsToStart:ThreeSecondsToStartSignal = new ThreeSecondsToStartSignal();
    public var mapLoaded:MapLoadedSignal = new MapLoadedSignal();
    public var readyToCreateGame:ReadyToCreateGameSignal = new ReadyToCreateGameSignal();
    public var gameReady:GameReadySignal = new GameReadySignal();
    public var gameStarted:GameStartedSignal = new GameStartedSignal();

    public var gameEnded:GameEndedSignal = new GameEndedSignal();
    public var readyToPlayAgain:ReadyToPlayAgainSignal = new ReadyToPlayAgainSignal();
    //---frame
    public var frameEntered:FrameEnteredSignal = new FrameEnteredSignal();

    private var oneSecondTimer:Timer = new Timer(1000);

    private var _gameType:GameType;


    function GameModel() {

        init();

        profileLoaded.add(onProfileLoaded);

        //todo:remove this code when profile loading will be available
        var profile:GameProfile = new GameProfile();
        profile.name = "id" + int(1000000 * Math.random());
        profileLoaded.dispatch(profile);
    }

    public function init():void {

        Context.gameServer.connected.add(onGameServerConnected);
        Context.gameServer.loggedIn.add(onLoggedIn);

        Context.gameServer.connectDefault();
    }

    private function onGameServerConnected():void {
        //todo: here should be special login process
        Context.gameServer.login(profileManager.name)
    }

    public function createSinglePlayerGame():void {


        gameReady.addOnce(function():void {
            TweenMax.delayedCall(3,function():void{
                gameStarted.dispatch();
            })
        })

        Context.game = gameBuilder.makeSinglePlayer(GameType.SINGLE, 11);
        if(Context.game.ready) {
            gameReady.dispatch();
        } else{
            mapLoaded.addOnce(function(xml:XML):void{
                gameReady.dispatch();
            })
        }
    }

    public function leaveCurrentGame():void {
        Context.gameServer.leaveCurrentGame();
    }

    public function quickJoin():void {
        Context.gameServer.quickJoinGame();
        Context.gameServer.joinedToGame.addOnce(onJoinedToGame)
    }


    public function setMeReady(ready:Boolean):void {
        Context.gameServer.notifyPlayerReadyChanged(ready);
    }

    public function tryCreateRegularGame(name:String, pass:String):void {
        Context.gameServer.createGameRoom(name, pass, GameType.REGULAR);
        Context.gameServer.joinedToGame.addOnce(onJoinedToGame);
        Context.gameServer.joinedToGame.addOnce(onGameCreated);
        Context.gameServer.roomCreationError.addOnce(onRoomCreationError);
    }

    private function onGameCreated():void {
        Context.gameServer.setRoomVars(GameType.REGULAR)
    }

    private function onRoomCreationError(message:String):void {
        Context.gameServer.joinedToGame.removeAll();
        Alert.show(message);
    }

    //--------------------------------HANDLERS--------------------------------

    private function onProfileLoaded(profile:GameProfile):void {
        profileManager = new ProfileManager(profile);
    }


    private function onLoggedIn(name:String):void {
        //todo: gameServer.setProfileVariable(profile);
        Context.gameServer.notifyPlayerReadyChanged(false);
        Context.gameServer.joinDefaultRoom();
    }


    private function onPing(e:TimerEvent):void {
        Context.gameServer.ping();
    }

    private function onJoinedToGame():void {
        connectedToGame.dispatch();
        Context.gameServer.roomCreationError.removeAll();

        //todo:room variables must have vars describing gameType and map.
        _gameType = GameType.REGULAR;

        connectedToGame.dispatch();

        var tim:Timer = new Timer(5000,1);
        tim.addEventListener(TimerEvent.TIMER_COMPLETE,function(e:Event){
            startPing();
        })

        threeSecondsToStart.addOnce(onThreeSecondsToStart);
    }

    private function startPing():void {
        oneSecondTimer.addEventListener(TimerEvent.TIMER, onPing)
        oneSecondTimer.start()
    }

    private function onSomeoneJoinedToGame(user:User):void {
    }

    private function onSomeoneLeftGame(user:User):void {
    }

    private function onThreeSecondsToStart(data:Array, mapId:int):void {
        gameStarted.addOnce(onGameStarted)
        Context.game = gameBuilder.makeFromRoom(Context.gameServer.gameRoom, mapId, data);
        if(Context.game.ready) {
            gameReady.dispatch();
        } else{
            mapLoaded.addOnce(function(xml:XML):void{
                gameReady.dispatch();
            })
        }
    }

    private function onGameStarted():void {
        gameEnded.addOnce(onGameEnded);
    }

    private function onGameEnded(/*parameters later*/):void {
        Context.game.destroy();
        setMeReady(false);
        readyToPlayAgain.addOnce(onReadyToPlayAgain)
    }

    private function onReadyToPlayAgain():void {
        Context.game.destroy();
        Context.game = null;
        //connectedToGame.dispatch();
        threeSecondsToStart.addOnce(onThreeSecondsToStart);
    }

    public function getUsersReadyState():Array {
        var result:Array = [];
        for each (var user:User in Context.gameServer.gameRoom.playerList) {
            var ready:Boolean = user.getVariable("ready").getBoolValue();
            result[user.playerId] = {userName:user.name,ready:ready};
        }
        return result;
    }

    // getters & setters
    public function get gameType():GameType {
        return _gameType;
    }


    public function set gameType(gameType:GameType):void {
        _gameType = gameType;
    }
}
}