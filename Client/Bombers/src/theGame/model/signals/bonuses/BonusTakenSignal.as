/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bonuses {
import org.osflash.signals.Signal;

import theGame.maps.mapObjects.bonuses.BonusType;
import theGame.maps.mapObjects.MapObjectType;

public class BonusTakenSignal extends Signal {
    public function BonusTakenSignal() {
        super(int,int,int,BonusType)
    }
}
}