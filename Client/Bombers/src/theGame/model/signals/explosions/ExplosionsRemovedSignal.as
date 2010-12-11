/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.explosions {
import mx.collections.ArrayList;

import org.osflash.signals.Signal;

public class ExplosionsRemovedSignal extends Signal{
    public function ExplosionsRemovedSignal() {
        super(ArrayList)
    }
}
}