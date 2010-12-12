/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
import com.smartfoxserver.v2.entities.User;

import theGame.bombers.PlayersBuilder;
import theGame.bombers.bots.AlongRightWallWalkingStrategy;
import theGame.bombers.interfaces.IBomber;
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.mapInfo.GameSkills;
import theGame.bombers.skin.BomberSkin;
import theGame.bombss.BombType;
import theGame.bombss.BombsBuilder;
import theGame.data.location1.maps.Maps;
import theGame.explosionss.ExplosionsBuilder;
import theGame.maps.builders.MapBlockBuilder;
import theGame.maps.builders.MapBlockStateBuilder;
import theGame.maps.builders.MapObjectBuilder;
import theGame.model.managers.regular.BonusManager;
import theGame.model.managers.regular.EnemiesManager;
import theGame.model.managers.regular.MapManager;
import theGame.model.managers.regular.PlayerManager;
import theGame.model.managers.singlePlayer.SinglePlayerBombsManager;
import theGame.model.managers.singlePlayer.SinglePlayerExplosionsManager;
import theGame.playerColors.PlayerColor;
import theGame.profiles.GameProfile;
import theGame.profiles.interfaces.IGameProfile;
import theGame.weapons.AtomBombWeapon;
import theGame.weapons.HameleonWeapon;
import theGame.weapons.WeaponType;

public class SinglePlayerGame extends GameBase implements IGame {


    public function SinglePlayerGame() {
        mapBlockStateBuilder = new MapBlockStateBuilder();
        mapObjectBuilder = new MapObjectBuilder();
        mapBlockBuilder = new MapBlockBuilder(mapBlockStateBuilder, mapObjectBuilder)

        _mapManager = new MapManager(mapBlockBuilder);

        explosionsBuilder = new ExplosionsBuilder(mapManager);
        bombsBuilder = new BombsBuilder(_mapManager, explosionsBuilder);
        playersBuilder = new PlayersBuilder(bombsBuilder);

        _playerManager = new PlayerManager();
        _enemiesManager = new EnemiesManager();

        _bombsManager = new SinglePlayerBombsManager(mapManager);
        _explosionsManager = new SinglePlayerExplosionsManager(explosionsBuilder, mapManager, playerManager);
        _bonusManager = new BonusManager(playerManager, mapManager);

        //game events
        Context.gameModel.gameStarted.addOnce(function():void {
            Context.gameModel.frameEntered.add(playerManager.movePlayer);
            Context.gameModel.frameEntered.add(enemiesManager.moveEnemies);
            Context.gameModel.frameEntered.add(bombsManager.checkBombs);
            Context.gameModel.frameEntered.add(explosionsManager.checkExplosions);
            Context.gameModel.frameEntered.add(bonusManager.checkBonusTaken);

            triedToSetBomb.add(function(x:int, y:int, type:BombType):void {
                bombSet.dispatch(playerManager.myId, x, y, type);
            });
            bombSet.add(onBombSet);

            triedToUseWeapon.add(onTriedToUseWeapon);
            weaponUsed.add(onWeaponUsed);

            bombExploded.add(onBombExploded);
            explosionsAdded.add(onExplosionsAdded)
            explosionsRemoved.add(onExplosionsRemoved)
        })
    }

    private function onWeaponUsed(playerId:int, x:int, y:int, type:WeaponType):void {
        var bomber:IBomber = getPlayer(playerId);
        bomber.useWeapon();
    }

    private function onTriedToUseWeapon(playerId:int, x:int, y:int, type:WeaponType):void {
        weaponUsed.dispatch(playerId,x,y,type);
    }


    public function addPlayer(mySelf:User, color:PlayerColor):void {
        //todo:here player's profile will be taken as user variable
        var profile:IGameProfile = new GameProfile();
        var gameSkills:IGameSkills = profile.getGameSkills();
        var gameSkin:BomberSkin = profile.getSkin(1);
        playerManager.setPlayer(playersBuilder.makePlayer(this, 1, profile.name, color, gameSkills,new AtomBombWeapon(mapManager,bombsBuilder), gameSkin));
    }

    public function addBot(color:PlayerColor):void {
        enemiesManager.addEnemy(playersBuilder.makeEnemyBot(this, enemiesManager.enemiesCount + 2, "bot" + enemiesManager.enemiesCount, color, new GameSkills(),new AtomBombWeapon(mapManager,bombsBuilder), new GameProfile().getSkin(enemiesManager.enemiesCount + 2), new AlongRightWallWalkingStrategy()))
    }


    public function get type():GameType {
        return GameType.SINGLE;
    }

    public override function destroy():void {
        super.destroy();
    }

    public function applyMap(mapId:int):void {
        var xml:XML = Maps.getXmlById(mapId);
        if (xml == null) { //need to load map
            Context.gameModel.mapLoaded.addOnce(onMapLoaded);
        } else {
            onMapLoaded(xml);
        }
    }

    private function onMapLoaded(xml:XML):void {
        mapManager.make(xml);
        playerManager.me.putOnMap(mapManager.map, mapManager.map.spawns[0].x, mapManager.map.spawns[0].y);
        enemiesManager.forEachAliveEnemy(function(enemy:IEnemyBomber, playerId:int) {
            enemy.putOnMap(mapManager.map, mapManager.map.spawns[playerId - 1].x, mapManager.map.spawns[playerId - 1].y)
        })
        _ready = true;
    }

}
}









