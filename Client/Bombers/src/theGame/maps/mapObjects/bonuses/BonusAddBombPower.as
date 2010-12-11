/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects.bonuses {
import theGame.bombers.interfaces.IBomber;
import theGame.maps.mapObjects.bonuses.BonusType;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapObjectType;

public class BonusAddBombPower extends BonusBase implements IBonus {


    public function BonusAddBombPower(block:IMapBlock) {
        super(block);
    }


    public function activateOn(player:IBomber):void {
        player.gameSkills.bombPower += 1;
        trace("player " + player.playerId + " collected bonus power , power = " + player.gameSkills.bombPower);
    }

    public function get type():IMapObjectType {
        return BonusType.ADD_BOMB_POWER;
    }

}
}