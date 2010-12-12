/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.view {
import flash.display.Sprite;

import theGame.interfaces.IDrawable;
import theGame.maps.IMap;
import theGame.maps.interfaces.IMapBlock;

public class MapBlocksView extends Sprite implements IDrawable {

    private var map:IMap;


    public function MapBlocksView(map:IMap) {
        this.map = map;

        for each (var block:IMapBlock in map.blocks) {
            addChild(new MapBlockView(block));
        }
        draw();
    }


    public function draw():void {
        for (var i:int = 0; i < numChildren; i++) {
            var child:IDrawable = getChildAt(i) as IDrawable;
            child.draw();
        }
    }
}
}
