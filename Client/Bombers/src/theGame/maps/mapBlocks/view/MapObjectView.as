/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.view {
import theGame.utils.greensock.TweenMax;

import flash.display.Sprite;

import theGame.data.Consts;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapObjects.MapObjectType;

public class MapObjectView extends Sprite implements IDrawable {

    private var block:IMapBlock;

    public function MapObjectView(block:IMapBlock) {
        super()
        this.block = block;
        this.block.objectCollected.add(onTakenAnimation)
    }

    public function draw():void {
        graphics.clear();
        if (block.object.type == MapObjectType.NULL)
            return;
        graphics.beginBitmapFill(Context.imageService.getObject(block.object.type));
        graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    public function onTakenAnimation(byMe:Boolean):void {
        if (byMe)
            TweenMax.to(this, 1, {x:"60",y:"-40",rotation:"360",scaleX:0,scaleY:0,alpha:0});
        else
            TweenMax.to(this, 0.7, {x:"20",y:"20",scaleX:0,scaleY:0,alpha:0});
    }
}
}