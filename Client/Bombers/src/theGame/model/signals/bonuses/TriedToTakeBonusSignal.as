/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bonuses {
import org.osflash.signals.Signal;

import theGame.maps.interfaces.IBonus;

public class TriedToTakeBonusSignal extends Signal {
    public function TriedToTakeBonusSignal() {
        super(IBonus);
    }
}
}