/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.utils {
import mx.collections.ArrayList;

public class ViewStateManager {

    private var target:IStatedView;
    private var viewStates:ArrayList = new ArrayList();

    public function ViewStateManager(target:IStatedView) {
        this.target = target;
    }

    public function addState(state:ViewState):void {
        viewStates.addItemAt(state, 0);
        applyState(state)
    }

    private function applyState(state:ViewState):void {
        for (var prop:String in state.properties) {
            target[prop] = state.properties[prop]
        }
        if (state.child != null)
            target.addChild(state.child);
        if (state.childTween != null)
            state.childTween.resume();
        if (state.tween != null) {
            setUpTween(state);
            state.tween.resume();
        }
        //update previous states' tweens' varsTo;
        for (var i:int = 1; i < viewStates.length; i++) {
            var prevState:ViewState = viewStates.getItemAt(i) as ViewState;
            for (prop in state.properties) {
                prevState.updateTween(prop, getCurrentProperty(prop))
            }
        }
    }

    public function setUpTween(state:ViewState):String {
        state.tween.target = target;
        //default properties
        for (var prop:String in state.tween.vars) {
            if (state.tween.vars[prop] == ViewState.GET_DEFAULT_VALUE) {
                state.tween.vars[prop] = getCurrentProperty(prop);
            }
        }
        return prop;
    }

    private function unApplyState(state:ViewState):void {
        removeChildAndTweens(state);
        for (var prop:String in target.tunableProperties) {
            if (state.affectsProperty(prop)) {
                refreshProperty(prop);
            }
        }
    }

    private function removeChildAndTweens(state:ViewState):void {
        if (state.child != null)
            target.removeChild(state.child);
        if (state.childTween != null) {
            state.childTween.complete();
        }
        if (state.tween != null) {
            state.tween.complete();
        }
    }

    public function refreshProperty(prop:String):void {
        var newState:ViewState = getAffectingState(prop)
        if (newState == null || newState.setsProperty(prop))
            target[prop] = getCurrentProperty(prop);
        else
            newState.updateTween(prop, getCurrentProperty(prop))
    }

    public function removeState(name:String):void {
        if (viewStates.length == 0)
            return;
        if (viewStates.getItemAt(0).name == name)
            popState();
        else
            for (var i:int = 1; i < viewStates.length; i++) {
                if (viewStates.getItemAt(i).name == name) {
                    pickStateOut(i);
                    return
                }
            }

    }

    private function popState():void {
        var state:ViewState = viewStates.removeItemAt(0) as ViewState
        unApplyState(state);

        if (viewStates.length == 0)
            for (var prop:String in target.tunableProperties) {
                target[prop] = getCurrentProperty(prop);
            }
    }

    private function pickStateOut(index:int):void {
        var state:ViewState = viewStates.removeItemAt(index) as ViewState;
        removeChildAndTweens(state);
        for (var prop:String in target.tunableProperties) {
            if (state.affectsProperty(prop)) {
                refreshProperty(prop);
            }
        }
    }

    private function getAffectingState(prop:String):ViewState {
        for (var i:int = 0; i < viewStates.length; i++) {
            var state:ViewState = viewStates.getItemAt(i) as ViewState;
            if (state.affectsProperty(prop))
                return state;
        }
        return null;
    }

    private function getCurrentProperty(prop:String):* {
        for (var i:int = 0; i < viewStates.length; i++) {
            var state:ViewState = viewStates.getItemAt(i) as ViewState;
            if (state.setsProperty(prop) || state.tweensProperty(prop))
                return state.getAffectedProperty(prop);
        }
        return target.getDefaultProperty(prop);
    }

    private function getCurrentIndex(prop:String):int {
        for (var i:int = 0; i < viewStates.length; i++) {
            var state:ViewState = viewStates.getItemAt(i) as ViewState;
            if (state.affectsProperty(prop))
                return i;
        }
        return -1;
    }

    public function deleteAllStates():void {
        viewStates.removeAll();
        for (var prop:String in target.tunableProperties) {
            target[prop] = getCurrentProperty(prop);
        }
    }
}


}
