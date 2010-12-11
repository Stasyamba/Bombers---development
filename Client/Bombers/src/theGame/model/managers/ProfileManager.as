/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers {
import theGame.bombers.interfaces.IGameSkin;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.skin.BomberSkin;
import theGame.model.managers.interfaces.IProfileManager;
import theGame.profiles.GameProfile;

public class ProfileManager implements IProfileManager {
    private var _profile:GameProfile;

    public function ProfileManager(profile:GameProfile) {
        _profile = profile;
    }

    public function getSkin():BomberSkin {
        //return _profile.getSkin();
        return null;
    }

    public function getMapSkills():IGameSkills {

        return _profile.getGameSkills();
    }

    public function get name():String {
        return _profile.name;
    }
}
}