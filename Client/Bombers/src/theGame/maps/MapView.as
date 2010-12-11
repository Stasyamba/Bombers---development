/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps {
import flash.display.Sprite;

import flash.geom.Point;

import mx.collections.ArrayList;

import theGame.data.Consts;
import theGame.data.location1.maps.MapBlocks;
import theGame.explosionss.ExplosionView;
import theGame.explosionss.interfaces.IExplosion;
import theGame.interfaces.IDestroyable;
import theGame.interfaces.IDrawable;
import theGame.maps.bigObjects.view.BigObjectView;
import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapBlocks.view.MapBlockView;

public class MapView extends Sprite implements IDrawable,IDestroyable  {


    public var map:IMap;
    private var pointsDrawnAfterExplosion:ArrayList = new ArrayList();

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

    public function drawAfterExplosion(x:int,y:int):void {
        graphics.beginBitmapFill(Context.imageService.getAfterExplosion());
        graphics.drawRect(x*Consts.BLOCK_SIZE, y*Consts.BLOCK_SIZE, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    public function MapView(map:IMap,explsView:ExplosionView) {
        super();
        this.map = map;
        addChild(explsView);
        for each (var block:IMapBlock in map.blocks) {
            addChild(new MapBlockView(block));
        }

        for each (var obj:IBigObject in map.bigObjects) {
            addChild(new BigObjectView(obj));
        }
        draw();

        Context.game.explosionsAdded.add(onExplosionsAdded)
    }

    private function onExplosionsAdded(expls:ArrayList):void {
        for each (var e:IExplosion in expls.source) {
            if(!hasDrawnAfterExplosionAt(e.centerX,e.centerY)){
                drawAfterExplosion(e.centerX,e.centerY);
                pointsDrawnAfterExplosion.addItem(new Point(e.centerX,e.centerY))
            }
        }
    }

    private function hasDrawnAfterExplosionAt(x:int, y:int):Boolean {
        for each (var point:Point in pointsDrawnAfterExplosion.source) {
             if(point.x == x && point.y == y)
                return true;
        }
        return false;
    }

    public function destroy():void {
        Context.game.explosionsAdded.removeAll();
    }
}
}