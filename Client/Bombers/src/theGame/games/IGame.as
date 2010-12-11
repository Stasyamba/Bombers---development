/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
import theGame.model.managers.interfaces.IBombsManager;
import theGame.model.managers.interfaces.IEnemiesManager;
import theGame.model.managers.interfaces.IExplosionsManager;
import theGame.model.managers.interfaces.IMapManager;
import theGame.model.managers.interfaces.IPlayerManager;
import theGame.model.managers.regular.BombsManager;
import theGame.model.signals.DieWallAppearedSignal;
import theGame.model.signals.weapons.TriedToUseWeaponSignal;
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
import theGame.model.signals.explosions.ExplosionsRemovedSignal;
import theGame.model.signals.explosions.ExplosionsUpdatedSignal;
import theGame.model.signals.movement.EnemyInputDirectionChangedSignal;
import theGame.model.signals.movement.EnemySmoothMovePerformedSignal;
import theGame.model.signals.movement.PlayerCoordsChangedSignal;
import theGame.model.signals.movement.PlayerInputDirectionChangedSignal;
import theGame.model.signals.movement.PlayerViewDirectionChangedSignal;

public interface IGame {

    function get ready():Boolean;

    function get type():GameType;

    function get enemyInputDirectionChanged():EnemyInputDirectionChangedSignal;

    function get bombSet():BombSetSignal;

    function get bombExploded():BombsExplodedSignal;

    function get enemyDamaged():EnemyDamagedSignal;

    function get enemyDied():EnemyDiedSignal;

    function get bonusAppeared():BonusAppearedSignal;

    function get bonusTaken():BonusTakenSignal;

    function get playerCoordinatesChanged():PlayerCoordsChangedSignal;

    function get playerViewDirectionChanged():PlayerViewDirectionChangedSignal;

    function get playerInputDirectionChanged():PlayerInputDirectionChangedSignal;

    function get triedToSetBomb():TriedToSetBombSignal;

    function get playerDied():PlayerDiedSignal;

    function get playerDamaged():PlayerDamagedSignal;

    function get triedToTakeBonus():TriedToTakeBonusSignal;

    function get playerManager():IPlayerManager;

    function get mapManager():IMapManager;

    function get enemiesManager():IEnemiesManager;

    function get explosionsUpdated():ExplosionsUpdatedSignal;

    function get explosionsRemoved():ExplosionsRemovedSignal;

    function get enemySmoothMovePerformed():EnemySmoothMovePerformedSignal;

    function get explosionsAdded():ExplosionsAddedSignal;

    function get explosionsManager():IExplosionsManager;

    function get bombsManager():IBombsManager;

    function destroy():void;

    function get deathWallAppeared():DieWallAppearedSignal;

    function get triedToUseWeapon():TriedToUseWeaponSignal;
}
}