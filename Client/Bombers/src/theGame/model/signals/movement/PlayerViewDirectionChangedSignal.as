/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.movement {
import org.osflash.signals.Signal;

import theGame.utils.Direction;

public class PlayerViewDirectionChangedSignal extends Signal {
    public function PlayerViewDirectionChangedSignal() {
        super(Number, Number, Direction)
    }
}
}