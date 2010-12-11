/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.builders {
import theGame.maps.interfaces.IMapObject;
import theGame.maps.mapObjects.NullMapObject;

public class MapObjectBuilder {

    public function make(objCode:uint):IMapObject {
        switch (objCode) {
            //TODO: make constant
            case 0:
                return NullMapObject.getInstance();
        }
        throw new Error("NotImplemented");
    }
}
}