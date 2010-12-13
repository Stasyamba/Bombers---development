/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss {
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.ExplosionsBuilder;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.explosionss.ExplosionType;
import theGame.model.managers.interfaces.IMapManager;

public class RegularBomb extends BombBase implements IBomb {

    private static const EXPLODE_TIME:Number = 2;

    protected var _power:int;

    public function RegularBomb(mapManager:IMapManager, explosionsBuilder:ExplosionsBuilder, block:IMapBlock, player:IBomber) {
        super(mapManager, explosionsBuilder, block, player);

        _power = player.gameSkills.bombPower;
        _explodeTime = EXPLODE_TIME;
    }


    public function explode():IExplosion {
        var expl:IExplosion = _explosionsBuilder.make(ExplosionType.REGULAR, block.x, block.y, power)
        expl.perform();
        _owner.gameSkills.bombCount += 1;
        return expl;
    }

    public function set power(value:int):void {
        _power = value;
    }

    public function get power():int {
        return _power;
    }

    public function get type():BombType {
        return BombType.REGULAR;
    }

    public function onSet():void {
        owner.gameSkills.bombCount -= 1;
    }
}
}