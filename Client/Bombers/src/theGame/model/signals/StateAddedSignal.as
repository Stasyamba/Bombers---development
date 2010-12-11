/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals {
import org.osflash.signals.Signal;

import theGame.utils.ViewState;

public class StateAddedSignal extends Signal {
    public function StateAddedSignal() {
        super(ViewState)
    }
}
}
