/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.singlePlayer {
import mx.collections.ArrayList;

import theGame.explosionss.*;
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.interfaces.IMapBlock;
import theGame.model.managers.interfaces.IExplosionsManager;
import theGame.model.managers.interfaces.IMapManager;
import theGame.model.managers.interfaces.IPlayerManager;
import theGame.model.managers.regular.*;

public class SinglePlayerExplosionsManager extends ExplosionsManager implements IExplosionsManager {


    public function SinglePlayerExplosionsManager(explosionsBuilder:ExplosionsBuilder, mapManager:IMapManager,playerManager:IPlayerManager) {
        super(explosionsBuilder, mapManager,playerManager)
    }

    override public function addExplosions(expls:ArrayList):void {
        super.addExplosions(expls);
        for each (var e:IExplosion in expls.source) {
            Context.game.enemiesManager.checkEnemiesMetExplosion(e);
        }

    }
}
}