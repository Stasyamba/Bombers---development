/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.weapons {
import com.greensock.TweenMax;

import flash.display.BlendMode;

import theGame.bombers.interfaces.IBomber;
import theGame.utils.ViewState;

public class HameleonWeapon implements IWeapon {

    private var charges:int;
    private var _isActivated:Boolean;

    public function HameleonWeapon(charges:int = 3) {
        this.charges = charges;
    }

    public function canActivateAt(x:uint, y:uint):Boolean {
        return charges > 0 && !_isActivated;
    }

    public function activateAt(x:uint, y:uint, by:IBomber):void {
        if (!canActivateAt(x, y))
            return;
        charges--;
        by.stateAdded.dispatch(new ViewState(ViewState.HAMELEON,{alpha:0.3,blendMode:BlendMode.MULTIPLY}))
        _isActivated = true;
        TweenMax.delayedCall(5, deactivate,[by]);
    }

    public function deactivate(by:IBomber):void {
        by.stateRemoved.dispatch(ViewState.HAMELEON)
        _isActivated = false;
    }

    public function get type():WeaponType {
        return WeaponType.HAMELEON;
    }

    public function get isActivated():Boolean {
        return _isActivated;
    }
}
}