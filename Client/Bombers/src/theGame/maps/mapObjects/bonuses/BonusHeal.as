/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapObjects.bonuses {
import theGame.bombers.interfaces.IBomber;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapObjectType;

public class BonusHeal extends BonusBase implements IBonus {

    public function BonusHeal(block:IMapBlock) {
        super(block)
    }

    public function activateOn(player:IBomber):void {
        if (player.life < player.gameSkills.startLife)
            player.life += 1;
    }

    public function get type():IMapObjectType {
        return BonusType.HEAL;
    }


}
}