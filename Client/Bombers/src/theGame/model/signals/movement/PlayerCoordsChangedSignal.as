/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.movement {
import org.osflash.signals.Signal;

/**
 * dispatches a bomber changed its' coords. Params:
 * x,y : Number - new view coords of bomber
 */
public class PlayerCoordsChangedSignal extends Signal {
    public function PlayerCoordsChangedSignal() {
        super(Number, Number);
    }
}
}