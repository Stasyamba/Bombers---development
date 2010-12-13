/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers {
import flash.utils.Dictionary;

import theGame.bombers.interfaces.IEnemyBomber;

public class EnemiesManagerBase {
    public function EnemiesManagerBase() {
    }

    private var enemies:Dictionary = new Dictionary();
    private var _enemiesCount:int = 0;

    public function addEnemy(enemy:IEnemyBomber):void {
        enemies[enemy.playerId] = enemy;// playersBuilder.makeEnemy(playerId, profile.name, mapCoords, makeSkills(profile), new GameSkin(makeSkin(profile)));
        _enemiesCount++;
    }

    public function removeEnemyById(playerId:int):void {
        enemies[playerId] = null;
        _enemiesCount--;
    }

    public function getEnemyById(playerId:int):IEnemyBomber {
        return enemies[playerId];
    }

    public function get enemiesCount():int {
        return _enemiesCount;
    }

    public function hasEnemy(playerId:int):Boolean {
        return !(enemies[playerId] == null);
    }


    public function forEachAliveEnemy(todo:Function):void {
        for (var i:int = 1; i <= _enemiesCount + 1; i++) {
            var enemy:IEnemyBomber = enemies[i];
            if (enemy != null && !enemy.isDead)
                todo(enemy, i);
        }
    }

    public function moveEnemies(elapsedMiliSecs:int):void {
        var elapsedSecs:Number = elapsedMiliSecs / 1000;
        forEachAliveEnemy(function (enemy:IEnemyBomber, playerId:int):void {
            enemy.move(elapsedSecs);
        })
    }
}
}