/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.ui {
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import mx.collections.ArrayList;
import mx.core.Container;
import mx.core.UIComponent;

import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.view.EnemyView;
import theGame.bombers.view.PlayerView;
import theGame.bombss.BombType;
import theGame.explosionss.ExplosionView;
import theGame.games.IGame;
import theGame.interfaces.IDestroyable;
import theGame.interfaces.IDrawable;
import theGame.maps.MapView;
import theGame.maps.OverMapView;
import theGame.maps.bigObjects.view.BigObjectsView;
import theGame.maps.mapBlocks.view.MapBlocksView;
import theGame.utils.Utils;

public class GameFieldView extends Container implements IDrawable,IDestroyable {

    private var game:IGame;
    /*--- layers from bottom to top*/

    //background and background objects
    public var mapView:MapView;
    //a layer between explosions and map. now is used to draw explosion prints
    public var overMapView:OverMapView;
    //bomb explosions (no die explosions here)
    public var explosionsView:ExplosionView;
    //interactive big objects players walk on
    public var lowerBigObjectsView:BigObjectsView;
    //map blocks : boxes,walls and so on
    public var mapBlocksView:MapBlocksView;
    //enemies
    public var enemiesViews:ArrayList = new ArrayList();
    //player
    public var playerView:PlayerView;
    //interactive big objects players walk under
    public var higherBigObjectsView:BigObjectsView;


    private var contentUI:UIComponent = new UIComponent();

    public function GameFieldView(game:IGame) {
        super();
        this.game = game;

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        mapView = new MapView(game.mapManager.map);
        contentUI.addChild(mapView);

        overMapView = new OverMapView(game.mapManager.map);
        contentUI.addChild(overMapView);

        explosionsView = new ExplosionView();
        contentUI.addChild(explosionsView);

        lowerBigObjectsView = new BigObjectsView(game.mapManager.map, false)
        contentUI.addChild(lowerBigObjectsView);

        mapBlocksView = new MapBlocksView(game.mapManager.map)
        contentUI.addChild(mapBlocksView);

        game.enemiesManager.forEachAliveEnemy(function todo(item:IEnemyBomber, playerId:int):void {
            var enemyView:EnemyView = new EnemyView(item);
            enemiesViews.addItem(enemyView);
            contentUI.addChild(enemyView);
        })

        playerView = new PlayerView(game.playerManager.me);
        contentUI.addChild(playerView);

        higherBigObjectsView = new BigObjectsView(game.mapManager.map, true);
        contentUI.addChild(higherBigObjectsView);

    }

    private function keyDown(event:KeyboardEvent):void {
        if (Utils.isArrowKey(event.keyCode)) {
            game.playerManager.me.addDirection(Utils.arrowKeyCodeToDirection(event.keyCode))
        } else if (event.keyCode == Keyboard.SPACE) {
            game.playerManager.me.setBomb(BombType.REGULAR);
        } else if (event.keyCode == Keyboard.CONTROL) {
            game.playerManager.me.tryUseWeapon();
        }
    }

    private function keyUp(event:KeyboardEvent):void {
        if (Utils.isArrowKey(event.keyCode)) {
            game.playerManager.me.removeDirection(Utils.arrowKeyCodeToDirection(event.keyCode))
        }
    }

    public function draw():void {
        mapView.draw();
        explosionsView.draw();
        playerView.draw();
        for each (var obj:IDrawable in enemiesViews) {
            obj.draw();
        }
    }

    private function addedToStageHandler(event:Event):void {

        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

        addElement(contentUI)
    }


    public function destroy():void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)

//        mapView.destroy();
//        explosionsView.destroy();
//        playerView.destroy();
//        for each (var enemyView:EnemyView in enemiesViews.source) {
//            enemyView.destroy();
//        }

    }
}
}