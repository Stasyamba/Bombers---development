/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps {
import flash.display.Sprite;

import mx.collections.ArrayList;

import theGame.data.Consts;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IMapBlock;

public class OverMapView extends Sprite implements IDrawable {

    private var map:IMap;
    private var prints:Vector.<Sprite>;

    public function OverMapView(map:IMap) {

        this.map = map;
        Context.game.explosionsRemoved.add(function(list:ArrayList) {
            draw();
        })

        prints = new Vector.<Sprite>();
        for each (var block:IMapBlock in map.blocks) {
            var print:Sprite = new Sprite();
            print.x = block.x * Consts.BLOCK_SIZE;
            print.y = block.y * Consts.BLOCK_SIZE;
            prints.push(print);
            addChild(print);
        }
    }

    private function getPrint(x:int, y:int):Sprite {
        return prints[y * map.width + x];
    }

    private function drawPrint(block:IMapBlock):void {
        var print:Sprite = getPrint(block.x, block.y);
        print.graphics.clear();
        if (block.hasExplosionPrint) {
            print.graphics.beginBitmapFill(Context.imageService.getExplosionPrint(block.explodedBy))
            print.graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
            print.graphics.endFill();
        }
    }

    public function draw():void {
        for each (var block:IMapBlock in map.blocks) {
            drawPrint(block);
        }
    }
}
}
