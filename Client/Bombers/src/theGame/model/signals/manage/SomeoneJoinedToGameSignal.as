/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.manage {
import com.smartfoxserver.v2.entities.User;

import org.osflash.signals.Signal;

public class SomeoneJoinedToGameSignal extends Signal {
    public function SomeoneJoinedToGameSignal() {
        super(User);
    }
}
}