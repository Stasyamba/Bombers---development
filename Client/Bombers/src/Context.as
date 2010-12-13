package {
import api.vkontakte.business.*;
import api.vkontakte.util.MD5;

import appmodel.ApplicationModel;

import theGame.games.IGame;
import theGame.imagesService.ImageService;
import theGame.model.GameModel;
import theGame.model.gameServer.GameServer;

public final class Context extends VyanaContext {

    function Context() {
        services = new VkontakteServices();
    }

    private var _gameModel:GameModel;
    private var _imageService:ImageService;
    private var _gameServer:GameServer;
    public var game:IGame;


    public static function wrongJSONToArray(source:String):Array {
        var tmpArr:Array = source.split("},{");
        if (tmpArr.length == 1) {
            return tmpArr;
        }

        var sideFlag:Boolean = false;
        for (var i:int = 0; i <= tmpArr.length - 1; i++) {
            if (!sideFlag)
                tmpArr[i] += "}";
            else
                tmpArr[i] = "{" + tmpArr[i];

            sideFlag = !sideFlag;
        }

        return tmpArr;
    }

    public static function isSettingsIncludeArr(settings:int, arrSettings:Array):Boolean {
        var res:Boolean = false;

        var arr:Array = [1,2,4,8,16,32,64,128,256,512,1024,2048];
        var tmpArr:Array = new Array();


        for each(var n:int in arrSettings) {
            tmpArr.push(n);
        }

        for (var i:int = arr.length - 1; i >= 0; i--) {
            if (settings - arr[i] >= 0) {
                settings -= arr[i];
                for (var j:int = 0; j <= tmpArr.length - 1; j++) {
                    if (tmpArr[j] == arr[i]) {
                        tmpArr[j] = 0;
                        break;
                    }
                }
            }
        }

        var summ:int = 0;
        for (var k:int = 0; k <= tmpArr.length - 1; k++) {
            summ += tmpArr[k];
        }

        if (summ == 0)
            res = true;

        return res;
    }

    public static function getSigObject():Object {
        var time:Number = Math.round(Math.random() * 100000);
        var rand:Number = Math.round(Math.random() * 400000);
        var sig:String = MD5.encrypt(Context.Model.currentSettings.ownVkProfile.id.toString() + time.toString() + rand.toString() + Context.Model.currentSettings.applicationSecret);

        var res:Object = new Object();
        res["time"] = time;
        res["rand"] = rand;
        res["sig"] = sig;

        return res;
    }

    public static function getInstance():Context {
        return VyanaContext.getInstance() as Context;
    }

    public static function get Model():ApplicationModel {
        if (!Context.getInstance().model) {
            Context.getInstance().model = new ApplicationModel();
        }
        return Context.getInstance().model as ApplicationModel;
    }

    public static function get gameModel():GameModel {
        if (!Context.getInstance()._gameModel) {
            Context.getInstance()._gameModel = new GameModel();
        }
        return Context.getInstance()._gameModel;
    }

    public static function get imageService():ImageService {
        if (!Context.getInstance()._imageService) {
            Context.getInstance()._imageService = new ImageService();
        }
        return Context.getInstance()._imageService;
    }

    public static function get gameServer():GameServer {
        if (!Context.getInstance()._gameServer) {
            Context.getInstance()._gameServer = new GameServer();
        }
        return Context.getInstance()._gameServer;
    }

    public static function get game():IGame {
        return Context.getInstance().game;
    }

    public static function set game(value:IGame):void {
        Context.getInstance().game = value;
    }


    public static function addEventListener(type:String, listener:Function, weak:Boolean = true):void {
        (Context.getInstance() as Context).addEventListener(type, listener, false, 0, weak);
    }
}
}