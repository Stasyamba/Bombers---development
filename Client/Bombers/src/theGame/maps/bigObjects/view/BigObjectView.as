/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects.view {
import flash.display.Sprite;

import mx.core.BitmapAsset;

import theGame.data.Consts;
import theGame.data.location1.mapObjects.BigObjectsSkins;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IBigObject;

public class BigObjectView extends Sprite  implements IDrawable {

    private var object:IBigObject;

    public function BigObjectView(obj:IBigObject) {
        super();
        object = obj;
        x = obj.elemX * Consts.BLOCK_SIZE;
        y = obj.elemY * Consts.BLOCK_SIZE;
        draw();
    }

    public function draw():void {
        graphics.clear();
        graphics.beginBitmapFill((new BigObjectsSkins[String(object.description.states[object.life])]() as BitmapAsset).bitmapData);
        graphics.drawRect(0, 0, object.description.width * Consts.BLOCK_SIZE, object.description.height * Consts.BLOCK_SIZE);
        graphics.endFill();
    }
}
}