package components.common {
[Bindable]
public class UserProfile {
    public static const BOY:int = 2;
    public static const GIRL:int = 1;
    public static const SEX_UNDEFINDED:int = 0;

    public static const VKONTAKTE_USERPROFILE_PREFIX:String = "http://vkontakte.ru/id";

    public var id:String = "";

    public var photoSrc:String = "";
    public var photoMediumSrc:String = "";
    public var photoBigSrc:String = "";

    public var firstName:String = "";
    public var lastName:String = "";
    public var fullName:String = "";

    public var sex:int = BOY;
    public var age:int = 18;
    public var cityId:int = -1;

    public var profileLink:String = "";

    public var isFriend:Boolean = false;

    public function UserProfile(idP:String) {
        id = idP;
        profileLink = VKONTAKTE_USERPROFILE_PREFIX + id;
    }


    public function clone(up:UserProfile, cloneOnlyEmptyFields:Boolean = false):void {
        if (!cloneOnlyEmptyFields) {
            id = up.id;
            photoSrc = up.photoSrc;
            photoMediumSrc = up.photoMediumSrc;
            photoBigSrc = up.photoBigSrc;
            firstName = up.firstName;
            lastName = up.lastName;
            fullName = up.fullName;

            sex = up.sex;
            age = up.age;
            cityId = up.cityId;

            isFriend = up.isFriend;
            profileLink = up.profileLink;
        } else {
            if (id == "") {
                id = up.id;
                profileLink = up.profileLink;
            }

            if (photoSrc == "") {
                photoSrc = up.photoSrc;
            }

            if (photoMediumSrc == "") {
                photoMediumSrc = up.photoMediumSrc;
            }

            if (photoBigSrc == "") {
                photoBigSrc = up.photoBigSrc;
            }

            if (firstName == "") {
                firstName = up.firstName;
            }

            if (lastName == "") {
                lastName = up.lastName;
            }

            if (fullName == "") {
                fullName = up.fullName;
            }

            sex = up.sex;
            age = up.age;
            cityId = up.cityId;

            isFriend = up.isFriend;
        }
    }

}
}