package {
import components.common.ApiResult;
import components.common.FlashVars;
import components.common.UserProfile;

import theGame.profiles.GameProfile;

[Bindable]
public class Settings {
    public var flashVars:FlashVars = new FlashVars();
    public var apiResult:ApiResult;

    public var applicationSecret:String = "";
    public var authKey:String = "";

    public var ownVkProfile:UserProfile;
    public var ownGameProfile:GameProfile = new GameProfile();

    public function Settings() {
    }

}
}