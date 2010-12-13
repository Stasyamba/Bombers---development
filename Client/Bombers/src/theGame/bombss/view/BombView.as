/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss.view {
import flash.display.BlendMode;
import flash.display.Sprite;

import theGame.bombss.NullBomb;
import theGame.data.Consts;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IMapBlock;

public class BombView extends Sprite implements IDrawable {
    private var block:IMapBlock;

    private var glow:Sprite = new Sprite;

    private var pulsing:Boolean = false;

    public function BombView(block:IMapBlock) {
        super();
        this.block = block;
        glow.blendMode = BlendMode.OVERLAY;
        addChild(glow);
    }


    public function draw():void {
        graphics.clear();
        if (block.bomb is NullBomb) {
            if (pulsing) stopPulsing();
            return;
        }
        if (!pulsing) startPulsing();

        graphics.beginBitmapFill(Context.imageService.getBomb(block.bomb.type, block.bomb.owner.color), null, false, true);
        graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    private function stopPulsing():void {
        pulsing = false;
        Context.gameModel.frameEntered.remove(onPulse);
    }

    private function startPulsing():void {
        pulsing = true;
        Context.gameModel.frameEntered.add(onPulse);
    }

    private function onPulse(elapsedMilliSecs:int):void {
        var offset:Number;
        var scale:Number;
        if (block.bomb.timeToExplode < 0.6) {
            offset = Context.game.bombsManager.fastOffset;
            scale = Context.game.bombsManager.fastScale;
        } else {
            offset = Context.game.bombsManager.pulseOffset;
            scale = Context.game.bombsManager.pulseScale;
        }
        x = offset;
        y = offset;
        scaleX = scale;
        scaleY = scale;
    }

//    private function drawGlow():void {
//        graphics.beginBitmapFill(block.bomb.owner.color.bombGlow,null,false,true);
//        graphics.drawRect(0, 0, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
//        graphics.endFill();
//    }

}
}