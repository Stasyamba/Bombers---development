/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss {
import theGame.explosionss.interfaces.IExplosion;
import theGame.model.explosionss.ExplosionType;

public class NullExplosion implements IExplosion {
    private static var instance:NullExplosion;

    public static function getInstance():NullExplosion {
        if (instance == null)
            instance = new NullExplosion();
        return instance;
    }

    public function get centerX():int {
        return -1;
    }

    public function get centerY():int {
        return -1;
    }

    function NullExplosion() {
    }

    public function perform():void {
    }

    public function addPoint(point:ExplosionPoint):void {
    }

    public function expireBy(elapsedSecs:Number):void {
    }

    public function expired():Boolean {
        return false;
    }

    public function forEachPoint(todo:Function):void {
    }

    public function getPoint(x:int, y:int):ExplosionPoint {
        return null;
    }

    public function get type():ExplosionType {
        return ExplosionType.NULL;
    }

    public function get damage():int {
        return 0;
    }
}
}