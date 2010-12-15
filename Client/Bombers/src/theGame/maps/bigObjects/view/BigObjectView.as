/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects.view {
import theGame.utils.greensock.TweenMax;

import flash.display.BlendMode;
import flash.display.Sprite;

import theGame.data.Consts;
import theGame.interfaces.IDrawable;
import theGame.maps.interfaces.IBigObject;
import theGame.utils.IStatedView;
import theGame.utils.ViewState;
import theGame.utils.ViewStateManager;

public class BigObjectView extends Sprite implements IDrawable,IStatedView {

    private var object:IBigObject;

    private var stateManager:ViewStateManager;

    private var _tunableProperties:Object = {x:true,y:true,alpha:true,blendMode:true,scaleX:true,scaleY:true};
    private var _defaultAlpha:Number = 1;

    public function BigObjectView(obj:IBigObject) {
        super();
        object = obj;
        x = obj.x * Consts.BLOCK_SIZE;
        y = obj.y * Consts.BLOCK_SIZE;

        stateManager = new ViewStateManager(this)

        obj.explosionStarted.add(onExplosionStarted)
        obj.explosionStopped.add(onExplosionStopped)
        obj.destroyed.add(onDestroyed)

        draw();

    }

    private function addState(state:ViewState):void {
        stateManager.addState(state);
        draw();
    }

    private function removeState(name:String):void {
        stateManager.removeState(name);
    }

    private function onDestroyed():void {
        _defaultAlpha = 0;
        stateManager.deleteAllStates();
        var tween:TweenMax = TweenMax.to(new Object(), 0.5, {alpha:0,paused:true,delay:0.7});

        var child:Sprite = new Sprite();

        for (var i:int = 0; i < 3; i++) {
            var expl:Sprite = new Sprite();
            expl.graphics.beginBitmapFill(Context.imageService.getDieExplosion(i))
            expl.graphics.drawRect(0, 0, 153, 159);
            expl.graphics.endFill();

            expl.x = this.width / 2 - 153 / 2;
            expl.y = this.height / 2 - 159 / 2;
            expl.alpha = 0;
            if (i > 0)
                expl.blendMode = BlendMode.OVERLAY;
            child.addChild(expl);
        }
        var childTween:TweenMax = TweenMax.to(child.getChildAt(0), 0.3, {alpha:1,paused:true,onComplete:function():void {
            TweenMax.to(child.getChildAt(1), 0.3, {alpha:1,onComplete: function():void {
                TweenMax.to(child.getChildAt(2), 0.3, {alpha:1,onComplete:function():void {
                    TweenMax.to(child, 0.3, {alpha:0})
                }})
            }})
        }});

        addState(new ViewState(ViewState.DYING_EXPLOSION, {alpha:1}, tween, child, childTween))
    }

    private function onExplosionStopped():void {
        removeState(ViewState.BLINKING);
    }

    private function onExplosionStarted():void {
        addState(new ViewState(ViewState.BLINKING, {}, TweenMax.fromTo(new Object(), Consts.BLINKING_TIME, {alpha:0}, {alpha:ViewState.GET_DEFAULT_VALUE, repeat:-1,yoyo:true,paused:true,data:{alpha:ViewState.GET_DEFAULT_VALUE}})))
    }

    public function draw():void {
        graphics.clear();
        graphics.beginBitmapFill(Context.imageService.getBigObject(object.description.skin));
        graphics.drawRect(0, 0, object.description.width * Consts.BLOCK_SIZE, object.description.height * Consts.BLOCK_SIZE);
        graphics.endFill();
    }

    public function get tunableProperties():Object {
        return _tunableProperties;
    }

    public function getDefaultProperty(prop:String):* {
        switch (prop) {
            case "x": return object.x * Consts.BLOCK_SIZE;
            case "y": return object.y * Consts.BLOCK_SIZE;
            case "alpha": return _defaultAlpha;
            case "blendMode":return BlendMode.NORMAL;
            case "scaleX": return 1.0;
            case "scaleY": return 1.0;
        }
        throw new ArgumentError("property " + prop + " is not supported")
    }
}
}