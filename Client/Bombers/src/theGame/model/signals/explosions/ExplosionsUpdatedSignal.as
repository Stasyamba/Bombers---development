/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.explosions {
import org.osflash.signals.Signal;

import theGame.explosionss.interfaces.IExplosion;

public class ExplosionsUpdatedSignal extends Signal {
    public function ExplosionsUpdatedSignal() {
        super(IExplosion)
    }
}
}