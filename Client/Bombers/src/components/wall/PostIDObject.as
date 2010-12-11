package components.wall {
[Bindable]
public class PostIDObject {
    public static const POSTID_DELIMETER_BASE:String = "bbbbbb";
    public static const POSTID_DELIMETER_INSIDEOBJECTS:String = "iii";

    public var type:int;

    public var photoURL:String;
    public var name:String;
    public var questId:int; // Array( {qeustId, rightAnswerId} );
    public var sex:int;

    public function PostIDObject() {
    }

    public function decode(source:String):void {
        var sourceArr:Array = source.split(POSTID_DELIMETER_BASE);

        photoURL = PostID.decode(sourceArr[0], PostID.TYPE_VKURL);
        name = PostID.decode(sourceArr[1], PostID.TYPE_RUSENGTEXT);
        sex = int(PostID.decode(sourceArr[2], PostID.TYPE_SIMPLE));
        //var quests: String = sourceArr[3];
        //var questsArr: Array = quests.split(POSTID_DELIMETER_INSIDEOBJECTS);

        /*for(var i: int = 0; i<= questsArr.length - 1; i+=2)
         {
         var questId: String = PostID.decode(questsArr[i], PostID.TYPE_SIMPLE);
         var rightAnsId: String = PostID.decode(questsArr[i+1], PostID.TYPE_SIMPLE);

         questsID.push({questId: questId, rightAnswerId: rightAnsId});
         }*/
    }

    public function encode(photoURLP:String, nameP:String, sexP:String):String {
        var result:String = "";

        result += PostID.encode(photoURLP, PostID.TYPE_VKURL) + POSTID_DELIMETER_BASE;
        result += PostID.encode(nameP, PostID.TYPE_RUSENGTEXT) + POSTID_DELIMETER_BASE;
        result += PostID.encode(sexP, PostID.TYPE_SIMPLE) + POSTID_DELIMETER_BASE;

        return result;
    }

    public function toString():String {
        var res:String = "";

        res += "photo: " + photoURL + "\n";
        res += "name: " + name + "\n";
        res += "sex:" + sex + "\n";
        res += "questId:" + questId.toString();
        /*for(var i: int = 0; i<= questsID.length - 1; i++)
         {
         res += "q id: "+questsID[i]["questId"] + "  ";
         res += "ra id: "+questsID[i]["rightAnswerId"] + "\n";
         }*/

        return res;
    }
}
}