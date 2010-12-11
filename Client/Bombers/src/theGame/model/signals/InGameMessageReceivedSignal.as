/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals {
import com.smartfoxserver.v2.entities.User;

import org.osflash.signals.Signal;

public class InGameMessageReceivedSignal extends Signal {
    public function InGameMessageReceivedSignal() {
        super(User,String);
    }
}
}
