/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.movement {
import org.osflash.signals.Signal;

public class EnemySmoothMovePerformedSignal extends Signal {
    public function EnemySmoothMovePerformedSignal() {
        super(int, Number, Number);
    }

}
}