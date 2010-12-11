/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects.bonuses {
import theGame.bombers.interfaces.IBomber;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapObjectType;

public class BonusAddBomb extends BonusBase implements IBonus {


    public function BonusAddBomb(block:IMapBlock) {
        super(block);
    }


    public function activateOn(player:IBomber):void {
        player.gameSkills.bombCount += 1;
        trace("player " + player.playerId + " collected bonus bomb , bombs = " + player.gameSkills.bombCount);
    }

    public function get type():IMapObjectType {
        return BonusType.ADD_BOMB;
    }

}
}