package theGame.profiles {
import components.pages.worldpage.worldspack.WorldsContext;

import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.mapInfo.GameSkills;
import theGame.bombers.skin.BomberSkin;
import theGame.profiles.interfaces.IGameProfile;

public class GameProfile implements IGameProfile {
    private var _name:String;
    public var expirance:int;

    public var currentLocation:int;
    public var currentWorld:int = WorldsContext.WORLD_DEFAULT;

    public var selectedWeaponLeftHand:int;
    public var selectedWeaponRightHand:int;

    public var selectedBomber:int;

    public function GameProfile() {
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function getGameSkills():IGameSkills {
        return new GameSkills();
    }

    public function getSkin(playerId:int):BomberSkin {
        if (playerId % 2 != 0)
            return Context.imageService.getBomberSkin("fury")
        return Context.imageService.getBomberSkin("robot")
    }


}
}