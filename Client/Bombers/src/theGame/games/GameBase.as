/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
import mx.collections.ArrayList;

import theGame.bombers.PlayersBuilder;
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.BombType;
import theGame.bombss.BombsBuilder;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.ExplosionPoint;
import theGame.explosionss.ExplosionsBuilder;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.builders.MapBlockBuilder;
import theGame.maps.builders.MapBlockStateBuilder;
import theGame.maps.builders.MapObjectBuilder;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.managers.interfaces.IBombsManager;
import theGame.model.managers.interfaces.IBonusManager;
import theGame.model.managers.interfaces.IEnemiesManager;
import theGame.model.managers.interfaces.IExplosionsManager;
import theGame.model.managers.interfaces.IMapManager;
import theGame.model.managers.interfaces.IPlayerManager;
import theGame.model.managers.regular.EnemiesManager;
import theGame.model.managers.regular.MapManager;
import theGame.model.signals.DieWallAppearedSignal;
import theGame.model.signals.WeaponUsedSignal;
import theGame.model.signals.bombs.BombSetSignal;
import theGame.model.signals.bombs.BombsExplodedSignal;
import theGame.model.signals.bombs.TriedToSetBombSignal;
import theGame.model.signals.bonuses.BonusAppearedSignal;
import theGame.model.signals.bonuses.BonusTakenSignal;
import theGame.model.signals.bonuses.TriedToTakeBonusSignal;
import theGame.model.signals.damage.EnemyDamagedSignal;
import theGame.model.signals.damage.EnemyDiedSignal;
import theGame.model.signals.damage.PlayerDamagedSignal;
import theGame.model.signals.damage.PlayerDiedSignal;
import theGame.model.signals.explosions.ExplosionsAddedSignal;
import theGame.model.signals.explosions.ExplosionsChangedSignal;
import theGame.model.signals.explosions.ExplosionsRemovedSignal;
import theGame.model.signals.explosions.ExplosionsUpdatedSignal;
import theGame.model.signals.movement.EnemyInputDirectionChangedSignal;
import theGame.model.signals.movement.EnemySmoothMovePerformedSignal;
import theGame.model.signals.movement.PlayerCoordsChangedSignal;
import theGame.model.signals.movement.PlayerInputDirectionChangedSignal;
import theGame.model.signals.movement.PlayerViewDirectionChangedSignal;
import theGame.model.signals.weapons.TriedToUseWeaponSignal;

public class GameBase {

    public function GameBase() {
    }

    //managers
    protected var _mapManager:MapManager;
    protected var _playerManager:IPlayerManager;
    protected var _enemiesManager:EnemiesManager;
    protected var _bombsManager:IBombsManager;
    protected var _explosionsManager:IExplosionsManager;
    protected var _bonusManager:IBonusManager;

    //builders
    public var bombsBuilder:BombsBuilder;
    public var explosionsBuilder:ExplosionsBuilder;
    public var mapBlockBuilder:MapBlockBuilder;
    public var mapObjectBuilder:MapObjectBuilder;
    public var mapBlockStateBuilder:MapBlockStateBuilder;
    public var playersBuilder:PlayersBuilder;

    //signals
    //---movement
    protected var _playerCoordinatesChanged:PlayerCoordsChangedSignal = new PlayerCoordsChangedSignal();
    protected var _playerViewDirectionChanged:PlayerViewDirectionChangedSignal = new PlayerViewDirectionChangedSignal();
    protected var _playerInputDirectionChanged:PlayerInputDirectionChangedSignal = new PlayerInputDirectionChangedSignal();
    protected var _enemyInputDirectionChanged:EnemyInputDirectionChangedSignal = new EnemyInputDirectionChangedSignal();
    protected var _enemySmoothMovePerformed:EnemySmoothMovePerformedSignal = new EnemySmoothMovePerformedSignal();
    //---bombs
    protected var _bombSet:BombSetSignal = new BombSetSignal();
    protected var _bombExploded:BombsExplodedSignal = new BombsExplodedSignal();
    protected var _triedToSetBomb:TriedToSetBombSignal = new TriedToSetBombSignal();
    //---weapons
    private var _triedToUseWeapon:TriedToUseWeaponSignal = new TriedToUseWeaponSignal();
    private var _weaponUsed:WeaponUsedSignal = new WeaponUsedSignal();
    //---explosions
    protected var _explosionsChanged:ExplosionsChangedSignal = new ExplosionsChangedSignal();
    protected var _explosionsAdded:ExplosionsAddedSignal = new ExplosionsAddedSignal();
    protected var _explosionsUpdated:ExplosionsUpdatedSignal = new ExplosionsUpdatedSignal();
    protected var _explosionsRemoved:ExplosionsRemovedSignal = new ExplosionsRemovedSignal();
    //---bonuses
    protected var _bonusAppeared:BonusAppearedSignal = new BonusAppearedSignal();
    protected var _triedToTakeBonus:TriedToTakeBonusSignal = new TriedToTakeBonusSignal();
    protected var _bonusTaken:BonusTakenSignal = new BonusTakenSignal();
    //---damage
    protected var _playerDamaged:PlayerDamagedSignal = new PlayerDamagedSignal();
    protected var _enemyDamaged:EnemyDamagedSignal = new EnemyDamagedSignal();
    protected var _playerDied:PlayerDiedSignal = new PlayerDiedSignal();
    protected var _enemyDied:EnemyDiedSignal = new EnemyDiedSignal();
    protected var _deathWallAppeared:DieWallAppearedSignal = new DieWallAppearedSignal();


    public function get playerCoordinatesChanged():PlayerCoordsChangedSignal {
        return _playerCoordinatesChanged;
    }

    public function get playerViewDirectionChanged():PlayerViewDirectionChangedSignal {
        return _playerViewDirectionChanged;
    }

    public function get playerInputDirectionChanged():PlayerInputDirectionChangedSignal {
        return _playerInputDirectionChanged;
    }

    public function get enemyInputDirectionChanged():EnemyInputDirectionChangedSignal {
        return _enemyInputDirectionChanged;
    }

    public function get enemySmoothMovePerformed():EnemySmoothMovePerformedSignal {
        return _enemySmoothMovePerformed;
    }

    public function get bombExploded():BombsExplodedSignal {
        return _bombExploded;
    }

    protected function get weaponUsed():WeaponUsedSignal {
        return _weaponUsed;
    }

    public function get triedToSetBomb():TriedToSetBombSignal {
        return _triedToSetBomb;
    }

    public function get triedToUseWeapon():TriedToUseWeaponSignal {
        return _triedToUseWeapon;
    }

    public function get explosionsChanged():ExplosionsChangedSignal {
        return _explosionsChanged;
    }

    public function get explosionsAdded():ExplosionsAddedSignal {
        return _explosionsAdded;
    }

    public function get explosionsUpdated():ExplosionsUpdatedSignal {
        return _explosionsUpdated;
    }

    public function get explosionsRemoved():ExplosionsRemovedSignal {
        return _explosionsRemoved;
    }

    public function get bonusAppeared():BonusAppearedSignal {
        return _bonusAppeared;
    }

    public function get triedToTakeBonus():TriedToTakeBonusSignal {
        return _triedToTakeBonus;
    }

    public function get bonusTaken():BonusTakenSignal {
        return _bonusTaken;
    }

    public function get playerDamaged():PlayerDamagedSignal {
        return _playerDamaged;
    }

    public function get enemyDamaged():EnemyDamagedSignal {
        return _enemyDamaged;
    }

    public function get playerDied():PlayerDiedSignal {
        return _playerDied;
    }

    public function get enemyDied():EnemyDiedSignal {
        return _enemyDied;
    }

    public function get mapManager():IMapManager {
        return _mapManager;
    }

    public function get playerManager():IPlayerManager {
        return _playerManager;
    }

    public function get enemiesManager():IEnemiesManager {
        return _enemiesManager;
    }

    public function get bombSet():BombSetSignal {
        return _bombSet;
    }

    public function get bombsManager():IBombsManager {
        return _bombsManager;
    }

    public function get bonusManager():IBonusManager {
        return _bonusManager;
    }

    public function get explosionsManager():IExplosionsManager {
        return _explosionsManager;
    }

    public function get deathWallAppeared():DieWallAppearedSignal {
        return _deathWallAppeared;
    }

    public function destroy():void {
        Context.gameModel.frameEntered.remove(playerManager.movePlayer);
        Context.gameModel.frameEntered.remove(enemiesManager.moveEnemies);
        Context.gameModel.frameEntered.remove(bombsManager.checkBombs);
        Context.gameModel.frameEntered.remove(explosionsManager.checkExplosions);
        Context.gameModel.frameEntered.remove(bonusManager.checkBonusTaken);


        triedToSetBomb.removeAll();
        bombSet.removeAll();

        triedToUseWeapon.removeAll();
        weaponUsed.removeAll();

        bombExploded.removeAll();
        explosionsAdded.removeAll()
        explosionsRemoved.removeAll()

        playerDamaged.removeAll()

        bonusAppeared.removeAll()
        triedToTakeBonus.removeAll()
        bonusTaken.removeAll();
    }

    public function getPlayer(playerId:int):IBomber {
        if (playerId == playerManager.myId)
            return playerManager.me;
        return enemiesManager.getEnemyById(playerId);
    }

    //----------------Handlers---------------

    protected function onBombSet(playerId:int, bombX:int, bombY:int, bombType:BombType):void {
        var owner:IBomber = getPlayer(playerId);
        var bomb:IBomb = bombsBuilder.makeBomb(bombType, mapManager.map.getBlock(bombX, bombY), owner)
        bomb.onSet();
        bombsManager.addBombAt(bombX, bombY, bomb);
    }

    protected function onBombExploded(bombX:int, bombY:int, power_bonus:int):void {
        bombsManager.explodeBombAt(bombX, bombY, power_bonus);
    }

    protected function onExplosionsRemoved(expls:ArrayList):void {
        for each (var e:IExplosion in expls.source)
            e.forEachPoint(function (point:ExplosionPoint):void {
                var b:IMapBlock = mapManager.map.getBlock(point.x, point.y);
                b.stopExplosion();
            })
    }

    protected function onExplosionsAdded(expls:ArrayList):void {
        explosionsManager.addExplosions(expls);
    }

    protected var _ready:Boolean = false;
    public function get ready():Boolean {
        return _ready;
    }


}
}