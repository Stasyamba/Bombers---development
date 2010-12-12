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

    public function BigObjectsView(map:IMap) {
        this.map = map;

        for each (var obj:IBigObject in map.bigObjects) {
            addChild(new BigObjectView(obj));
        }
    }

    public function draw():void {
        for (var i:int = 0; i < numChildren; i++) {
            var child:IDrawable = getChildAt(i) as IDrawable;
            child.draw();
        }
    }
}
}
