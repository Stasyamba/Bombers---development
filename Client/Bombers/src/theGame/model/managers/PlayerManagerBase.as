/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers {
import theGame.bombers.interfaces.IPlayerBomber;
import theGame.data.Consts;
import theGame.explosionss.ExplosionPoint;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IBonus;
import theGame.maps.interfaces.IMapBlock;

public class PlayerManagerBase {
    public function PlayerManagerBase() {
    }

    protected var _me:IPlayerBomber;

    public function setPlayer(player:IPlayerBomber):void {
        _me = player;
    }

    public function movePlayer(elapsedMiliSecs:int):void {
        if (me.isDead)
            return;
        var elapsedSecs:Number = elapsedMiliSecs / 1000;
        me.move(elapsedSecs);
    }

    //todo: later maybe let explosion manager explode players, here just return bool
    public function checkPlayerMetExplosion(expl:IExplosion):void {
        if (me.isDead)
            return;
        if (me.isImmortal) return;
        var b:IMapBlock = me.coords.getPartBlock();
        var def:Number = me.coords.getPartBlockDef();

        expl.forEachPoint(function(point:ExplosionPoint):void {
            if (me.isImmortal) return;
            if (me.coords.elemX == point.x && me.coords.elemY == point.y)
                me.explode(expl);
            else if (b.x == point.x && b.y == point.y && def > Consts.EXPLOSION_DEFLATION)
                me.explode(expl);
        })
    }

    public function get me():IPlayerBomber {
        return _me;
    }

    public function get myId():int {
        return _me.playerId;
    }

    public function checkPlayerTakenBonus(bonus:IBonus):Boolean {
        if (me.isDead)
            return false;
        var b:IMapBlock = me.coords.getPartBlock();
        if (me.coords.elemX == bonus.x && me.coords.elemY == bonus.y
                || b.x == bonus.x && b.y == bonus.y) {
            if (!bonus.wasTriedToBeTaken) {
                me.tryTakeBonus(bonus);
                return true;
            }
        }
        return false;
    }

    public function checkPlayerMetDieWall(x:int, y:int):Boolean {
        if (me.isDead)
            return false;
        var b:IMapBlock = me.coords.getPartBlock();
        var def:Number = me.coords.getPartBlockDef();
        if (me.coords.elemX == x && me.coords.elemY == y)
            return true;
        else if (b.x == x && b.y == y && def > Consts.EXPLOSION_DEFLATION)
            return true;
        return false;

    }

    public function killMe():void {
        me.kill();
    }
}
}