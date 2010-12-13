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
import theGame.maps.interfaces.IBigObject;

public class MapView extends Sprite implements IDrawable,IDestroyable {


    public var map:IMap;


    public function draw():void {
        graphics.clear();
        drawBackground();
    }

    public function drawBackground():void {

        removeAllChildren();

        graphics.beginBitmapFill(MapBlocks.MAP_GRASS());
        graphics.drawRect(0, 0, map.width * Consts.BLOCK_SIZE, map.height * Consts.BLOCK_SIZE);
        graphics.endFill();

        for each (var obj:IBigObject in map.decorations) {
            var sp:Sprite = new Sprite()
            sp.graphics.beginBitmapFill(Context.imageService.getBigObject(obj.description.skin));
            sp.graphics.drawRect(0, 0, obj.description.width * Consts.BLOCK_SIZE, obj.description.height * Consts.BLOCK_SIZE);
            sp.graphics.endFill();
            sp.x = obj.x * Consts.BLOCK_SIZE;
            sp.y = obj.y * Consts.BLOCK_SIZE;
            addChild(sp);
        }
    }

    private function removeAllChildren():void {
        while (numChildren != 0) {
            removeChildAt(0);
        }
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