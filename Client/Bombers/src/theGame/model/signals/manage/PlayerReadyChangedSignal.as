/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.manage {
import com.smartfoxserver.v2.entities.User;

import org.osflash.signals.Signal;

public class PlayerReadyChangedSignal extends Signal {
    public function PlayerReadyChangedSignal() {
        super(User)
    }
}
}