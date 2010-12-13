/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import org.osflash.signals.Signal;

import theGame.explosionss.interfaces.IExplosion;

public interface IBigObject {


    function get x():int;

    function get y():int;

    function get life():int;

    function get description():IBigObjectDescription;

    function get isDestroyed():Boolean;

    function explode(expl:IExplosion):void;

    function destroy():void;

    function get explosionStopped():Signal;

    function get explosionStarted():Signal;

    function get destroyed():Signal;
}
}