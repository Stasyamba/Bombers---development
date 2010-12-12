/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps {
import flash.display.Sprite;

import theGame.data.Consts;
import theGame.data.location1.maps.MapBlocks;
import theGame.interfaces.IDestroyable;
import theGame.interfaces.IDrawable;

public class MapView extends Sprite implements IDrawable,IDestroyable {


    public var map:IMap;


    public function draw():void {
        drawBackground();

        for (var i:int = 0; i < numChildren; i++) {
            var child:IDrawable = getChildAt(i) as IDrawable;
            child.draw();
        }
    }

    public function drawBackground():void {
        graphics.beginBitmapFill(MapBlocks.MAP_GRASS());
        graphics.drawRect(0, 0, map.width * Consts.BLOCK_SIZE, map.height * Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    public function MapView(map:IMap) {
        super();
        this.map = map;
        draw();
    }

    public function destroy():void {

    }
}
}