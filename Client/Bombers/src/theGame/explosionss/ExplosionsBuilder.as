/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss {
import theGame.explosionss.interfaces.IExplosion;
import theGame.model.explosionss.ExplosionType;
import theGame.model.managers.interfaces.IMapManager;

public class ExplosionsBuilder {
    private var mapManager:IMapManager;

    public function ExplosionsBuilder(mapManager:IMapManager) {
        this.mapManager = mapManager;
    }

    public function make(explType:ExplosionType, centerX:int = -1, centerY:int = -1, power:int = -1):IExplosion {
        switch (explType) {
            case ExplosionType.REGULAR:
                return new Explosion(mapManager.map, centerX, centerY, power)
            case ExplosionType.ATOM:
                return new AtomExplosion(mapManager.map, centerX, centerY)
            case ExplosionType.NULL:
                return NullExplosion.getInstance();
        }
        throw new ArgumentError("Not implemented making explosions of type \"" + explType.value + "\"")
    }
}
}