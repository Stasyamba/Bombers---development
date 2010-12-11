/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.weapons {
import theGame.bombers.interfaces.IBomber;

public class NullWeapon implements IWeapon {
    public function NullWeapon() {
    }

    public function activateAt(x:uint, y:uint, by:IBomber):void {
    }

    public function canActivateAt(x:uint, y:uint):Boolean {
        return false;
    }

    public function get type():WeaponType {
        return WeaponType.NULL;
    }
}
}