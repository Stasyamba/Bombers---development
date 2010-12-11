/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombss {
import theGame.bombers.interfaces.IBomber;
import theGame.bombss.interfaces.IBomb;
import theGame.explosionss.ExplosionsBuilder;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.managers.regular.MapManager;

public class BombsBuilder {

    private var mapManager:MapManager;
    private var explosionsBuilder:ExplosionsBuilder;

    public function BombsBuilder(mapManager:MapManager, explosionsBuilder:ExplosionsBuilder) {
        this.mapManager = mapManager;
        this.explosionsBuilder = explosionsBuilder;
    }

    public function makeBomb(type:BombType, block:IMapBlock, player:IBomber):IBomb {
        switch (type) {
            case BombType.REGULAR:
                return new RegularBomb(mapManager, explosionsBuilder, block, player);
            case BombType.ATOM:
                return new AtomBomb(mapManager, explosionsBuilder, block, player);
        }
        throw new ArgumentError(" don't support this bomb type");
    }
}
}