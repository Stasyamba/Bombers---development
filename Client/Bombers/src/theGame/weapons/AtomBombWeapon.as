/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.weapons {
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.BombType;
import theGame.bombss.BombsBuilder;
import theGame.model.managers.interfaces.IMapManager;

public class AtomBombWeapon implements IWeapon {

    private var charges:int;
    private var mapManager:IMapManager;
    private var bombsBuilder:BombsBuilder;

    public function AtomBombWeapon(mapManager:IMapManager, bombsBuilder:BombsBuilder, charges:int = 3) {
        this.mapManager = mapManager;
        this.charges = charges;
        this.bombsBuilder = bombsBuilder;
    }

    public function activateAt(x:uint, y:uint, by:IBomber):void {
        if (!canActivateAt(x, y)) return;
        charges--;
        Context.game.bombSet.dispatch(by.playerId, x, y, BombType.ATOM)
    }

    public function canActivateAt(x:uint, y:uint):Boolean {
        if (!mapManager.canUseMap)
            return false;
        return charges > 0 && mapManager.map.getBlock(x, y).canSetBomb();
    }

    public function get type():WeaponType {
        return WeaponType.ATOM_BOMB_WEAPON;
    }


}
}