/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.weapons {
import theGame.bombers.interfaces.IBomber;

public interface IWeapon {

    function activateAt(x:uint, y:uint, by:IBomber):void;

    function canActivateAt(x:uint, y:uint):Boolean;

    function get type():WeaponType;
}
}