/*
 * Copyright (c) 2010. 
 * Pavkin Vladimir
 */

package theGame.explosionss {
import theGame.utils.Direction;

public class ExplosionPointType {
    public static const NONE:ExplosionPointType = new ExplosionPointType("NONE");
    public static const CROSS:ExplosionPointType = new ExplosionPointType("CROSS");
    public static const VERTICAL:ExplosionPointType = new ExplosionPointType("VERTICAL");
    public static const HORIZONTAL:ExplosionPointType = new ExplosionPointType("HORIZONTAL");
    public static const LEFT:ExplosionPointType = new ExplosionPointType("LEFT");
    public static const RIGHT:ExplosionPointType = new ExplosionPointType("RIGHT");
    public static const UP:ExplosionPointType = new ExplosionPointType("UP");
    public static const DOWN:ExplosionPointType = new ExplosionPointType("DOWN");

    private var _type:String;

    function ExplosionPointType(type:String) {
        this._type = type;
    }

    public static function getEdge(dir:Direction):ExplosionPointType {
        switch (dir) {
            case Direction.LEFT:
                return LEFT;
            case Direction.RIGHT:
                return RIGHT;
            case Direction.UP:
                return UP;
            case Direction.DOWN:
                return DOWN;
            default:
                throw new ArgumentError("Invalid edge direction");
        }
    }

    public static function getExplosionPointType(willExplosionExpand:Boolean, direction:Direction):ExplosionPointType {

        if (willExplosionExpand) {
            if (Direction.isHorizontal(direction))
                return HORIZONTAL;
            else
                return VERTICAL;
        }
        return getEdge(direction);
    }

    public static function addTypes(type1:ExplosionPointType, type2:ExplosionPointType):ExplosionPointType {
        if (type1 == type2)
            return type1;
        if (type1 == HORIZONTAL)
            if (type2 == LEFT || type2 == RIGHT)
                return HORIZONTAL;
        if (type2 == HORIZONTAL)
            if (type1 == LEFT || type1 == RIGHT)
                return HORIZONTAL;

        if (type1 == VERTICAL)
            if (type2 == UP || type2 == DOWN)
                return VERTICAL;
        if (type2 == VERTICAL)
            if (type1 == UP || type1 == DOWN)
                return VERTICAL;
        return CROSS;
    }

    public function get value():String {
        return _type;
    }
}
}