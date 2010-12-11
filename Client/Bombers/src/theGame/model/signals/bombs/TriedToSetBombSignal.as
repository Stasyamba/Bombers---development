/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bombs {
import org.osflash.signals.Signal;

import theGame.bombss.BombType;

public class TriedToSetBombSignal extends Signal {
    public function TriedToSetBombSignal() {
        super(int, int, BombType)
    }
}
}