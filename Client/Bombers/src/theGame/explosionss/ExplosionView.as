/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss {
import flash.display.BitmapData;
import flash.display.Sprite;

import theGame.data.Consts;
import theGame.explosionss.interfaces.IExplosion;
import theGame.imagesService.ImageService;
import theGame.interfaces.IDestroyable;
import theGame.interfaces.IDrawable;
import theGame.model.explosionss.ExplosionType;

public class ExplosionView extends Sprite implements IDrawable,IDestroyable  {

    private var explosion:IExplosion;

    public function ExplosionView() {
        super();
        explosion = Context.game.explosionsManager.allExplosions;
        Context.game.explosionsUpdated.add(onExplosionsUpdated)
        draw();
    }

    private function onExplosionsUpdated(expl:IExplosion):void {
        explosion = expl;
        draw();
    }

    public function draw():void {
        graphics.clear();
        if (explosion != null && explosion.type != ExplosionType.NULL) {
            explosion.forEachPoint(function(point:ExplosionPoint):void {
                graphics.beginBitmapFill(Context.imageService.getExplosion(explosion.type,point.type));
                graphics.drawRect(point.x * Consts.BLOCK_SIZE, point.y * Consts.BLOCK_SIZE, Consts.BLOCK_SIZE, Consts.BLOCK_SIZE);
                graphics.endFill();
            })
        }
    }


    public function destroy():void {
        Context.game.explosionsUpdated.removeAll()
    }
}
}