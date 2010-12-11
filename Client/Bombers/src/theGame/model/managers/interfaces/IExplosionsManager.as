/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.interfaces {
import mx.collections.ArrayList;

import theGame.explosionss.interfaces.IExplosion;

public interface IExplosionsManager {
    function addExplosion(expl:IExplosion):void;

    function checkExplosions(elapsedMiliSecs:Number):void;

    function addExplosions(expls:ArrayList):void;

    function updateAllExplosions():void;

    function get allExplosions():IExplosion;
}
}