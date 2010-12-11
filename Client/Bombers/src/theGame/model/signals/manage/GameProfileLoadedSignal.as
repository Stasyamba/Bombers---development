/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.signals.manage {
import org.osflash.signals.Signal;

import theGame.profiles.GameProfile;

public class GameProfileLoadedSignal extends Signal {
    public function GameProfileLoadedSignal() {
        super(GameProfile)
    }
}
}