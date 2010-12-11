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

public class BonusAddSpeed extends BonusBase implements IBonus {



    public function BonusAddSpeed(block:IMapBlock) {
        super(block);
    }


    public function activateOn(player:IBomber):void {
        player.gameSkills.speed *= 1.1;
        trace("player " + player.playerId + " collected bonus speed , speed = " + player.gameSkills.speed);
    }

    public function get type():IMapObjectType {
        return BonusType.ADD_SPEED;
    }

}
}