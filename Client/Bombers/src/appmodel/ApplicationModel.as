package appmodel {
import api.vkontakte.constant.UserProfileField;
import api.vkontakte.model.VkontakteApplicationModel;

import components.common.UserProfile;

import flash.events.EventDispatcher;

import org.vyana.control.VyanaEvent;

public class ApplicationModel extends VkontakteApplicationModel {

    public static const APPLICATION_ID:String = '2027731';
    public static const APPLICATION_LINK:String = "http://www.vkontakte.ru/app1954763";
    public static const APPLICATION_SECRET:String = 'DeKn5rLVzT';
    public static const APPLICATION_AUTHOR_ID:String = '72969483';

    function ApplicationModel() {
        super(APPLICATION_ID, APPLICATION_SECRET, APPLICATION_AUTHOR_ID);

    }

    public function getUsersProfiles(uidP:Array, afterEvent:String = "", addToLoadedUsers:Boolean = true):void {
        new VyanaEvent(APIVkontakte.GET_PROFILE_FIELDS,
        {
            uids: uidP,
            fields: [UserProfileField.UID, UserProfileField.SEX, UserProfileField.PHOTO_BIG, UserProfileField.PHOTO, UserProfileField.PHOTO_MEDIUM, UserProfileField.FIRST_NAME, UserProfileField.LAST_NAME, UserProfileField.NICKNAME]
        }).dispatch(
                   function (result:*):void {

                       var returningData:Array = new Array();

                       for each (var o:* in result.response) {

                           var up:UserProfile = new UserProfile(o[UserProfileField.UID]);
                           up.sex = o[UserProfileField.SEX];
                           up.firstName = o[UserProfileField.FIRST_NAME];
                           up.lastName = o[UserProfileField.LAST_NAME];
                           up.photoBigSrc = o[UserProfileField.PHOTO_BIG];
                           up.photoSrc = o[UserProfileField.PHOTO];
                           up.photoMediumSrc = o[UserProfileField.PHOTO_MEDIUM];

                           if (addToLoadedUsers) {
                               Context.Model.currentSettings.apiResult.loadedUsers = pushIntoArray(up, Context.Model.currentSettings.apiResult.loadedUsers, "id");
                           }

                           returningData.push(up);
                       }

                       if (afterEvent == "") {
                           dispatchCustomEvent(ContextEvent.USERS_PROFILES_LOADED, returningData);
                       } else {
                           dispatchCustomEvent(afterEvent, returningData);
                       }
                   });
    }

    public function wallSavePhotoID(wallIdP:String, photoIdP:String, postIdP:String, messageP:String):void {

        new VyanaEvent(APIVkontakte.SAVE_WALL_POST,
        {
            wall_id: wallIdP,
            photo_id: photoIdP,
            post_id: postIdP,
            message: messageP
        }).dispatch(
                   function (result:*):void {
                       for each (var o:* in result.response) {
                           //mx.controls.Alert.show("responce:"+ObjectUtil.toString(result.response));
                       }
                   });
    }

    public function pushIntoArray(val:*, arr:Array, compareProperty:String = ""):Array {
        var newArray:Array = arr;
        var elementFinded:Boolean = false;

        for each(var o:* in arr) {
            if (compareProperty != "") {
                // it's mean that o is Simple

                if (o.hasOwnProperty(compareProperty)) {
                    if (val[compareProperty] == o[compareProperty]) {
                        elementFinded = true;
                    }
                }
            } else {
                if (val == o) {
                    elementFinded = true;
                }
            }
        }

        if (!elementFinded) {
            newArray.push(val);
        }

        return newArray;
    }

    [Bindable]
    public var currentSettings:Settings = new Settings();

    [Bindable]
    public var trustContent:Boolean = true;


    public var disp:EventDispatcher;

    public function hasCustomListener(event:String):Boolean {
        if (disp == null) return false;
        return disp.hasEventListener(event);
    }

    public function addCustomListener(event:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        if (disp == null) disp = new EventDispatcher();
        disp.addEventListener(event, listener, useCapture, priority, useWeakReference);
    }

    public function dispatchCustomEvent(event:String, data:* = null):void {
        if (disp == null) return;
        disp.dispatchEvent(new ContextEvent(event, false, false, data));
    }

    public function removeCustomEventListener(event:String, func:Function):void {
        if (disp != null && disp.hasEventListener(event)) {
            disp.removeEventListener(event, func);
        }
    }
}
}