/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss {
public class ExplosionPoint {

    private var _type:ExplosionPointType;
    private var _x:int;
    private var _y:int;

    public function ExplosionPoint(x:int, y:int, type:ExplosionPointType) {
        _x = x;
        _y = y;
        _type = type;
    }

    public function get type():ExplosionPointType {
        return _type;
    }

    public function set type(value:ExplosionPointType):void {
        _type = value;
    }

    public function get x():int {
        return _x;
    }

    public function get y():int {
        return _y;
    }
}
}