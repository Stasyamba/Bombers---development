/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals {
import org.osflash.signals.Signal;

public class DieWallAppearedSignal extends Signal {
    public function DieWallAppearedSignal() {
        super(int, int);
    }
}
}