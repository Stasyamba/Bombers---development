/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects {
import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IBigObjectDescription;

public class BigObject implements IBigObject {

    private var _elemX:int;
    private var _elemY:int;
    private var _life:int;
    private var _description:IBigObjectDescription;

    public function BigObject(elemX:int, elemY:int, description:IBigObjectDescription, life:int = -1) {
        _elemX = elemX;
        _elemY = elemY;
        _description = description;
        _life = life == -1 ? description.defaultLife : life;

    }

    public function get elemX():int {
        return _elemX;
    }

    public function get elemY():int {
        return _elemY;
    }

    public function get life():int {
        return _life;
    }

    public function get description():IBigObjectDescription {
        return _description;
    }
}
}