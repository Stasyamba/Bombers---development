/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.bombs {
import org.osflash.signals.Signal;

import theGame.bombss.BombType;

public class BombsExplodedSignal extends Signal {
    public function BombsExplodedSignal() {
        super(int,int,int);
    }
}
}