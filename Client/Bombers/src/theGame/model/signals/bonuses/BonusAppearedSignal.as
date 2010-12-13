/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bonuses {
import org.osflash.signals.Signal;

import theGame.maps.mapObjects.bonuses.BonusType;

public class BonusAppearedSignal extends Signal {
    public function BonusAppearedSignal() {
        super(int, int, BonusType)
    }
}
}