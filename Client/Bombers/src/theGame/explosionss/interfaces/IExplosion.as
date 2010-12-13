/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss.interfaces {
import theGame.explosionss.ExplosionPoint;
import theGame.model.explosionss.ExplosionType;

public interface IExplosion {

    function perform():void;

    function addPoint(point:ExplosionPoint):void;

    function expireBy(elapsedSecs:Number):void;

    function expired():Boolean;

    function get type():ExplosionType;

    /*
     * do(point:ExplosionPoint):void
     * */
    function forEachPoint(todo:Function):void;

    function getPoint(x:int, y:int):ExplosionPoint;

    function get damage():int;

    function get centerX():int;

    function get centerY():int;
}
}