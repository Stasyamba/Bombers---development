/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
import flash.display.DisplayObject;

public interface IStatedView {
    function addChild(child:DisplayObject):DisplayObject;

    function removeChild(child:DisplayObject):DisplayObject;

    function get tunableProperties():Object;

    function getDefaultProperty(prop:String):*;
}
}
