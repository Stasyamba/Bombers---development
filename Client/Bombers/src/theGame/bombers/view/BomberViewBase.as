/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.view {
import com.greensock.TweenMax;

import flash.display.BlendMode;
import flash.display.Sprite;

import theGame.bombers.interfaces.IBomber;
import theGame.bombers.skin.SkinElement;
import theGame.data.Consts;
import theGame.interfaces.IDrawable;
import theGame.utils.IStatedView;
import theGame.utils.ViewState;
import theGame.utils.ViewStateManager;

public class BomberViewBase extends Sprite implements IDrawable,IStatedView {

    protected var _bomber:IBomber;

    protected var healthBar:Sprite = new Sprite();

    protected var _mask:Sprite;

    private var stateManager:ViewStateManager;

    private var _tunableProperties:Object = {x:true,y:true,alpha:true,blendMode:true,scaleX:true,scaleY:true};
    private var _defaultAlpha:Number = 1;

    public function BomberViewBase(bomber:IBomber) {
        super();
        _bomber = bomber;
        this.x = bomber.coords.getRealX();
        this.y = bomber.coords.getRealY();
        healthBar = new Sprite();
        healthBar.x = int((Consts.BLOCK_SIZE - Consts.HEALTH_BAR_WIDTH) / 2)
        healthBar.y = -4;
        addChild(healthBar);

        stateManager = new ViewStateManager(this);

        this._bomber.stateAdded.add(addState);
        this._bomber.stateRemoved.add(removeState);
        draw();
    }

    private function addState(state:ViewState):void {
        stateManager.addState(state);
        draw();
    }

    private function removeState(name:String):void {
        stateManager.removeState(name);
    }

    public function draw():void {
        if (_mask != null && this.contains(_mask))
            removeChild(_mask);

        if (_bomber.isDead) {
            graphics.clear()
            removeChild(healthBar);
            return;
        }

        drawHealthBar();

        graphics.clear();

        var directionSkin:SkinElement = _bomber.gameSkin.currentSkin;

        graphics.beginBitmapFill(directionSkin.skin.bitmapData);
        graphics.drawRect(0, 0, Consts.BOMBER_SIZE, Consts.BOMBER_SIZE);
        graphics.endFill();

        rotation = 0;

        _mask = _bomber.gameSkin.currentMask;
        addChildAt(_mask, 0);
    }

    private function drawHealthBar():void {
        healthBar.graphics.clear();
        healthBar.graphics.beginBitmapFill(Context.imageService.getHealthBar(_bomber.life / _bomber.gameSkills.startLife));
        healthBar.graphics.drawRect(0, 0, Consts.HEALTH_BAR_WIDTH, Consts.HEALTH_BAR_HEIGHT)
        healthBar.graphics.endFill();
    }

    protected function onDied():void {
        _defaultAlpha = 0;
        stateManager.deleteAllStates();
        var tween:TweenMax = TweenMax.to(new Object(), 0.5, {alpha:0,paused:true,delay:0.7});

        var child:Sprite = new Sprite();

        for (var i:int = 0; i < 3; i++) {
            var expl:Sprite = new Sprite();
            expl.graphics.beginBitmapFill(Context.imageService.getDieExplosion(i))
            expl.graphics.drawRect(0, 0, 153, 159);
            expl.graphics.endFill();
            expl.x = -56;
            expl.y = -60;
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

    public function get tunableProperties():Object {
        return _tunableProperties;
    }

    public function getDefaultProperty(prop:String):* {
        switch (prop) {
            case "x": return _bomber.coords.getRealX();
            case "y": return _bomber.coords.getRealY();
            case "alpha": return _defaultAlpha;
            case "blendMode":return BlendMode.NORMAL;
            case "scaleX": return 1.0;
            case "scaleY": return 1.0;
        }
        throw new ArgumentError("property " + prop + " is not supported")
    }
}
}