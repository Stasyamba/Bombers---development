/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.manage {
import org.osflash.signals.Signal;

public class LoggedInSignal extends Signal {
    public function LoggedInSignal() {
        super(String);
    }
}
}