/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
import theGame.utils.greensock.TweenMax;

import flash.display.Sprite;

public class ViewState {
    private var _name:String;
    private var _properties:Object;
    private var _child:Sprite;
    private var _childTween:TweenMax;
    private var _tween:TweenMax;

    public static const GET_DEFAULT_VALUE:String = "$default";

    public static const BLINKING:String = "blinking";
    public static const HAMELEON:String = "hameleon";
    public static const DYING_EXPLOSION:String = "dyingExplosion";


    public function ViewState(name:String, properties:Object, tween:TweenMax = null, child:Sprite = null, childTween:TweenMax = null) {
        _name = name;
        _properties = properties;
        _tween = tween;
        _child = child;
        _childTween = childTween;
        if (_tween != null && _tween.data == null)
            _tween.data = {};
    }

    public function get name():String {
        return _name;
    }

    public function get properties():Object {
        return _properties;
    }

    public function get child():Sprite {
        return _child;
    }

    public function get childTween():TweenMax {
        return _childTween;
    }

    public function get tween():TweenMax {
        return _tween;
    }

    public function affectsProperty(prop:String):Boolean {
        return setsProperty(prop) || tweensProperty(prop) || hasValueDependentTween(prop);
    }

    public function getAffectedProperty(prop:String):* {
        if (setsProperty(prop))
            return properties[prop];
        if (tweensProperty(prop))
            return tween.vars[prop];
        return null;
    }

    public function setsProperty(prop:String):Boolean {
        return properties[prop] != null;
    }

    public function tweensProperty(prop:String):Boolean {
        return (tween != null && tween.vars[prop] != null && tween.data[prop] != ViewState.GET_DEFAULT_VALUE);
    }

    public function hasValueDependentTween(prop:String):Boolean {
        return (tween != null && tween.vars[prop] != null && tween.data[prop] == ViewState.GET_DEFAULT_VALUE);
    }

    /****
     *
     * @param todo
     * function(name:String,value:*,isTweened:Boolean);
     */
    public function forEachAffectedProperty(todo:Function):void {
        for (var prop:String in properties) {
            todo(prop, properties[prop], false);
        }
        if (tween != null)
            for (prop in tween.vars) {
                todo(prop, tween.vars[prop], true);
            }
    }

    public function updateTween(prop:String, value:*):void {
        if (!hasValueDependentTween(prop))
            return;
        var obj:Object = new Object();
        obj[prop] = value;
        tween.updateTo(obj);
    }
}
}