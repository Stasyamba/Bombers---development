/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals {
import org.osflash.signals.Signal;

import theGame.weapons.WeaponType;

public class WeaponUsedSignal extends Signal {
    public function WeaponUsedSignal() {
        super(int, int, int, WeaponType)
    }
}
}