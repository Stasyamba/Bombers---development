/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.explosions {
import mx.collections.ArrayList;

import org.osflash.signals.Signal;

public class ExplosionsAddedSignal extends Signal{
    public function ExplosionsAddedSignal() {
        super(ArrayList);
    }
}
}