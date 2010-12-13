/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects.view {
import flash.display.Sprite;

import theGame.interfaces.IDrawable;
import theGame.maps.IMap;
import theGame.maps.interfaces.IBigObject;

public class BigObjectsView extends Sprite implements IDrawable {

    private var map:IMap;
    private var isHigher:Boolean;


    public function BigObjectsView(map:IMap, isHigher:Boolean) {
        this.map = map;
        this.isHigher = isHigher;

        for each (var obj:IBigObject in getObjects()) {
            addChild(new BigObjectView(obj));
        }
    }

    public function draw():void {
        for (var i:int = 0; i < numChildren; i++) {
            var child:IDrawable = getChildAt(i) as IDrawable;
            child.draw();
        }
    }

    public function getObjects():Vector.<IBigObject> {
        return isHigher ? map.higherBigObjects : map.lowerBigObjects
    }
}
}
