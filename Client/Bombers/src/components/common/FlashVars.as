package components.common {
public class FlashVars {
    public var viewerType:String;
    public var groupId:String;
    public var referrer:String;
    public var posterId:String;
    public var postId:String;
    public var scaleMode:String;
    public var userId:String;

    public static const WALL_VIEW_INLINE:String = "wall_view_inline";

    public function FlashVars() {
    }


    public function toString():String {
        var res:String = "";
        res += " viewerType: " + viewerType + "\n";
        res += " referrer: " + referrer + "\n";
        res += " groupId: " + groupId + "\n";
        res += " userId: " + userId + "\n";
        res += " posterId: " + posterId + "\n";
        res += " postId: " + postId + "\n";

        return res;
    }
}
}