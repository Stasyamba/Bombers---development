/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks.view {
import flash.display.BitmapData;
import flash.display.Sprite;

import theGame.bombss.NullBomb;
import theGame.bombss.view.BombView;
import theGame.data.Consts;
import theGame.data.location1.bombs.Bombs;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapObjects.MapObjectType;
import theGame.maps.mapObjects.NullMapObject;
import theGame.utils.Utils;

public class MapBlockView extends Sprite implements IDrawable {

    private var block:IMapBlock;
    private var blinking:Boolean = false;
    private var blinkingTime:Number = Consts.BLINKING_TIME;

    private var bombView:BombView;
    private var objectView:MapObjectView;
    
    public function MapBlockView(block:IMapBlock) {
        super();
        this.block = block;
        x = block.x * Consts.BLOCK_SIZE;
        y = block.y * Consts.BLOCK_SIZE;

        block.viewUpdated.add(draw);

        block.explosionStarted.add(function():void{
            Context.gameModel.frameEntered.add(onBlink)
            blinking = true;
            draw();
        })
        block.explosionStopped.add(function():void{
            Context.gameModel.frameEntered.remove(onBlink)
        })
        bombView = new BombView(block);
        objectView = new MapObjectView(block);

        addChild(objectView);
        addChild(bombView);
        draw();
    }

    private function onBlink(elapsedMilliSecs:int):void {
        if(!block.isExplodingNow){
            blinking = false;
            draw();
            return
        }
        blinkingTime-=elapsedMilliSecs/1000;
        if(blinkingTime<=0){
            blinkingTime+=Consts.BLINKING_TIME;
            draw();
            blinking = !blinking;
        }
    }

    public function draw():void {
        graphics.clear();

        drawExplosion();
        drawBlock();

        drawBomb();
        drawObject();
        drawHiddenObject();
    }

    private function drawHiddenObject():void {
        if(block.isExplodingNow && block.hiddenObject.type != MapObjectType.NULL){
            trace("DRAWN HIDDEN")
            graphics.beginBitmapFill(Context.imageService.getObject(block.hiddenObject.type));
            graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
            graphics.endFill();
        }
    }

    private function drawBomb():void {
        bombView.draw();
    }

    private function drawObject():void {
        objectView.draw();
        objectView.visible =block.canShowObjects;

    }

    private function drawBlock():void {
        trace("DRAWN AT " + block.x + "," + block.y);
        if(blinking) return;
        var bData:BitmapData = Context.imageService.getMapBlock(block.type)
        if (bData == null) return;
        graphics.beginBitmapFill(bData);
        graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    private function drawExplosion():void {
//        if (block.isExploded && !block.isExplodingNow) {
//            graphics.beginBitmapFill(Context.imageService.getAfterExplosion());
//            graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
//            graphics.endFill();
//        }
    }
}
}