package {
import flash.events.Event;

public class ContextEvent extends Event {
    public static const USERS_PROFILES_LOADED:String = "UsersProfileLoaded";

    public static const MAIN_TAB_CHANGED:String = "MainTabChanged";
    public static const NEED_TO_CHANGE_MAIN_TAB:String = "NeedToChangeMainTab";

    public static const SHOW_MAIN_PREALODER:String = "ShowMainPreloder";
    public static const NEED_TO_SHOW_ERROR:String = "NeedToShowError";


    // worlds and locations
    public static const NEED_TO_CHANGE_WORLD:String = "NeedToChangeWorld";
    public static const NEED_TO_CHANGE_LOCATION:String = "NeedToChangeLocation";


    public static const BOMBER_CHANGED:String = "BomberChanged";

    public static const GAME_PROFILE_LOADED:String = "GameProfileLoaded";

    public var data:*;

    public function ContextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:* = null) {
        super(type, bubbles, cancelable);
        this.data = data;
    }

    public override function toString():String {
        return formatToString("ContextEvent", "type", "bubbles", "cancelable", "eventPhase", "data");
    }

    public override function clone():Event {
        return new ContextEvent(type, bubbles, cancelable, data);
    }

}
}