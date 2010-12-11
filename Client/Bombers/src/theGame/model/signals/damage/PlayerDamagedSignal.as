/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.damage {
import org.osflash.signals.Signal;

public class PlayerDamagedSignal extends Signal {
    public function PlayerDamagedSignal() {
        super(Number, Boolean);
    }
}
}