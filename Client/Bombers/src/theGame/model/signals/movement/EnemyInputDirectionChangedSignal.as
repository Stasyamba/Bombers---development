/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.movement {
import org.osflash.signals.Signal;

import theGame.utils.Direction;

public class EnemyInputDirectionChangedSignal extends Signal {
    public function EnemyInputDirectionChangedSignal() {
        super(int, Number, Number, Direction)
    }
}
}