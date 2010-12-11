/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bombs {
import org.osflash.signals.Signal;

import theGame.bombss.BombType;

public class BombSetSignal extends Signal {
    public function BombSetSignal() {
        super(int, int, int, BombType)
    }
}
}