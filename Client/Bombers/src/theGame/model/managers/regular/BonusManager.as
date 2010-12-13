/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.regular {
import mx.collections.ArrayList;

import theGame.bombers.interfaces.IBomber;
import theGame.maps.interfaces.IBonus;
import theGame.maps.mapObjects.bonuses.BonusType;
import theGame.model.managers.interfaces.IBonusManager;
import theGame.model.managers.interfaces.IEnemiesManager;
import theGame.model.managers.interfaces.IMapManager;
import theGame.model.managers.interfaces.IPlayerManager;

public class BonusManager implements IBonusManager {

    private var playerManager:IPlayerManager;
    private var enemiesManager:IEnemiesManager;

    private var mapManager:IMapManager;

    private var _bonuses:ArrayList = new ArrayList();

    public function BonusManager(playerManager:IPlayerManager, mapManager:IMapManager) {
        this.playerManager = playerManager;
        this.mapManager = mapManager;
    }

    public function checkBonusTaken(elapsedMiliSecs:int):void {
        var l:int = _bonuses.length;
        for (var i:int = 0; i < l; i++) {
            var bonus:IBonus = _bonuses.getItemAt(i) as IBonus;
            if (playerManager.checkPlayerTakenBonus(bonus)) {
                //                _bonuses.removeItem(bonus);
                //                i--;
                //                l--;
            }
        }
    }

    public function addBonus(bonus:IBonus):void {
        bonus.block.setObject(bonus);
        trace("bonus " + (bonus.type as BonusType).key + " added at " + bonus.block.x + "," + bonus.block.y)
        _bonuses.addItem(bonus);
    }

    public function takeBonus(x:int, y:int, player:IBomber):void {
        var bonus:IBonus = getBonusAt(x, y);
        trace("bonus " + (bonus.type as BonusType).key + " taken at " + x + "," + y);
        bonus.activateOn(player)
        bonus.block.collectObject(playerManager.myId == player.playerId);
        _bonuses.removeItem(bonus);
    }

    private function getBonusAt(x:int, y:int):IBonus {
        for each (var bonus:IBonus in _bonuses.source) {
            if (x == bonus.x && y == bonus.y)
                return bonus;
        }
        return null
    }
}
}