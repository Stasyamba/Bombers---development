/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
import com.smartfoxserver.v2.entities.User;

import theGame.bombers.PlayersBuilder;
import theGame.bombers.interfaces.IBomber;
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.interfaces.IPlayerBomber;
import theGame.bombers.skin.BomberSkin;
import theGame.bombss.BombType;
import theGame.bombss.BombsBuilder;
import theGame.data.location1.maps.Maps;
import theGame.explosionss.ExplosionsBuilder;
import theGame.maps.builders.MapBlockBuilder;
import theGame.maps.builders.MapBlockStateBuilder;
import theGame.maps.builders.MapObjectBuilder;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapObjects.bonuses.BonusAddBomb;
import theGame.maps.mapObjects.bonuses.BonusAddBombPower;
import theGame.maps.mapObjects.bonuses.BonusAddSpeed;
import theGame.maps.mapObjects.bonuses.BonusHeal;
import theGame.maps.mapObjects.bonuses.BonusType;
import theGame.model.managers.regular.BombsManager;
import theGame.model.managers.regular.BonusManager;
import theGame.model.managers.regular.EnemiesManager;
import theGame.model.managers.regular.ExplosionsManager;
import theGame.model.managers.regular.MapManager;
import theGame.model.managers.regular.PlayerManager;
import theGame.playerColors.PlayerColor;
import theGame.profiles.GameProfile;
import theGame.profiles.interfaces.IGameProfile;
import theGame.utils.Direction;
import theGame.weapons.AtomBombWeapon;

public class RegularGame extends GameBase implements IGame {


    public function RegularGame() {

        mapBlockStateBuilder = new MapBlockStateBuilder();
        mapObjectBuilder = new MapObjectBuilder();
        mapBlockBuilder = new MapBlockBuilder(mapBlockStateBuilder, mapObjectBuilder)

        _mapManager = new MapManager(mapBlockBuilder);

        explosionsBuilder = new ExplosionsBuilder(mapManager);
        bombsBuilder = new BombsBuilder(_mapManager, explosionsBuilder);
        playersBuilder = new PlayersBuilder(bombsBuilder);

        _playerManager = new PlayerManager();
        _enemiesManager = new EnemiesManager();

        _bombsManager = new BombsManager(mapManager);
        _explosionsManager = new ExplosionsManager(explosionsBuilder, mapManager, playerManager);
        _bonusManager = new BonusManager(playerManager, mapManager)

        //game events
        Context.gameModel.gameStarted.addOnce(function() {

            playerInputDirectionChanged.add(onPlayerInputDirectionChanged);
            playerViewDirectionChanged.add(onPlayerViewDirectionChanged)

            Context.gameModel.frameEntered.add(playerManager.movePlayer);
            Context.gameModel.frameEntered.add(enemiesManager.moveEnemies);
            Context.gameModel.frameEntered.add(bombsManager.checkBombs);
            Context.gameModel.frameEntered.add(explosionsManager.checkExplosions);
            Context.gameModel.frameEntered.add(bonusManager.checkBonusTaken);


            triedToSetBomb.add(onTriedToSetBomb);
            bombSet.add(onBombSet);

            bombExploded.add(onBombExploded);
            explosionsAdded.add(onExplosionsAdded)
            explosionsRemoved.add(onExplosionsRemoved)

            playerDamaged.add(onPlayerDamaged)

            bonusAppeared.add(onBonusAppeared)
            triedToTakeBonus.add(tryToTakeBonus)
            bonusTaken.add(onBonusTaken);

            deathWallAppeared.add(onDieWallAppeared)
        })

    }

    public function addPlayer(user:User, color:PlayerColor):void {
        //todo:here player's profile will be taken as user variable
        var profile:IGameProfile = new GameProfile();
        var gameSkills:IGameSkills = profile.getGameSkills();
        var gameSkin:BomberSkin = profile.getSkin(user.playerId);
        if (user.isItMe) {

            //todo:make a weaponBuilder
            var player:IPlayerBomber = playersBuilder.makePlayer(this, user.playerId, user.name, color, gameSkills,new AtomBombWeapon(mapManager,bombsBuilder), gameSkin);
            playerManager.setPlayer(player);
        } else {
            //todo: here get profile from user variables and use it to make enemy
            var enemy:IEnemyBomber = playersBuilder.makeEnemy(this, user.playerId, user.name, color, gameSkills,new AtomBombWeapon(mapManager,bombsBuilder),gameSkin);
            enemiesManager.addEnemy(enemy);
        }
    }


    public function hasPlayer(playerId:int):Boolean {
        return playerManager.myId == playerId || enemiesManager.hasEnemy(playerId);
    }

    public function applyMap(mapId:int, spawnData:Array):void {
        var xml:XML = Maps.getXmlById(mapId);
        if (xml == null) {
            Context.gameModel.mapLoaded.addOnce(function (lXml:XML) {
                onMapLoaded(lXml, spawnData);
            })
        } else {
            onMapLoaded(xml, spawnData)
        }
    }

    private function onMapLoaded(xml:XML, spawnData:Array):void {
        mapManager.make(xml);
        spawnData.forEach(
                function setCoords(item:*, index:int, array:Array):void {

                    var bomber:IBomber = getPlayer(item.id);
                    if(bomber != null)
                        bomber.putOnMap(mapManager.map, item.x, item.y);
                })
        _ready = true;
    }

    private function onDieWallAppeared(x:int, y:int):void {
        mapManager.setDieWall(x, y);
        if (playerManager.checkPlayerMetDieWall(x, y)) {
            playerManager.killMe();
        }
    }


    public function get numberOfPlayers():int {
        return enemiesManager.enemiesCount + 1;
    }


    private function onPlayerInputDirectionChanged(x:Number, y:Number, dir:Direction, viewDirChanged:Boolean):void {
        Context.gameServer.notifyPlayerDirectionChanged(x, y, dir, viewDirChanged)
    }

    private function onPlayerViewDirectionChanged(x:Number, y:Number, dir:Direction):void {
        Context.gameServer.notifyPlayerViewDirectionChanged(x, y, dir)
    }

    public function onTriedToSetBomb(bombX:int, bombY:int, type:BombType):void {
        Context.gameServer.notifyTryingToSetBomb(bombX, bombY, type)
    }


    private function onBonusTaken(id:int, x:int, y:int, bonusType:BonusType):void {
        var bomber:IBomber = getPlayer(id);
        bonusManager.takeBonus(x, y, bomber);
    }

    private function tryToTakeBonus(bonus:IBonus):void {
        Context.gameServer.notifyActivateObject(bonus);
    }

    private function onBonusAppeared(x:int, y:int, bonusType:BonusType):void {
        var b:IMapBlock = mapManager.map.getBlock(x, y);
        var bonus:IBonus;
        switch (bonusType) {
            case BonusType.ADD_BOMB:
                bonus = new BonusAddBomb(b);
                break;
            case BonusType.ADD_BOMB_POWER:
                bonus = new BonusAddBombPower(b);
                break;
            case BonusType.ADD_SPEED:
                bonus = new BonusAddSpeed(b);
                break;
            case BonusType.HEAL:
                bonus = new BonusHeal(b);
                break;
            default:
                throw new Error("invalid bonus type")
        }
        bonusManager.addBonus(bonus);
    }

    private function onPlayerDamaged(damage:int, isDead:Boolean):void {
        Context.gameServer.notifyPlayerDamaged(damage, isDead);
    }

    //--------------getters and setters-----------------------
    public function get type():GameType {
        return GameType.REGULAR;
    }

}
}