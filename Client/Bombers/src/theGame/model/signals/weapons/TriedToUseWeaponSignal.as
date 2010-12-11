/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.weapons {
import org.osflash.signals.Signal;

import theGame.weapons.IWeapon;
import theGame.weapons.WeaponType;

public class TriedToUseWeaponSignal extends Signal {
    public function TriedToUseWeaponSignal() {
        super(int,int,int,WeaponType);
    }
}
}