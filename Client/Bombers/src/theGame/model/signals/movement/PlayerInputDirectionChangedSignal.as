/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.movement {
import org.osflash.signals.Signal;

import theGame.utils.Direction;

public class PlayerInputDirectionChangedSignal extends Signal {
    public function PlayerInputDirectionChangedSignal() {
        super(Number, Number, Direction, Boolean)
    }
}
}