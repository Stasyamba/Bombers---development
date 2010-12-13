/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.builders {
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.interfaces.IMapObject;
import theGame.maps.interfaces.IMapObjectType;
import theGame.maps.mapObjects.MapObjectType;
import theGame.maps.mapObjects.NullMapObject;
import theGame.maps.mapObjects.bonuses.BonusAddBomb;
import theGame.maps.mapObjects.bonuses.BonusAddBombPower;
import theGame.maps.mapObjects.bonuses.BonusAddSpeed;
import theGame.maps.mapObjects.bonuses.BonusHeal;
import theGame.maps.mapObjects.bonuses.BonusType;

public class MapObjectBuilder {

    public function make(objType:IMapObjectType, block:IMapBlock):IMapObject {
        switch (objType) {
            case MapObjectType.NULL:
                return NullMapObject.getInstance();
            //bonuses
            case BonusType.ADD_BOMB:
                return new BonusAddBomb(block)
            case BonusType.ADD_BOMB_POWER:
                return new BonusAddBombPower(block)
            case BonusType.ADD_SPEED:
                return new BonusAddSpeed(block);
            case BonusType.HEAL:
                return new BonusHeal(block);
        }
        throw new Error("NotImplemented");
    }
}
}