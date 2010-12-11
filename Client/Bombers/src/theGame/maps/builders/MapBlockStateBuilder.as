/*
 * Copyright (c) 2010. 
 * Pavkin Vladimir
 */

package theGame.maps.builders {
import theGame.maps.interfaces.IMapBlockState;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.maps.mapBlocks.NullMapBlock;
import theGame.maps.mapBlocks.mapBlockStates.BoxBlock;
import theGame.maps.mapBlocks.mapBlockStates.FragileWallBlock;
import theGame.maps.mapBlocks.mapBlockStates.FreeBlock;
import theGame.maps.mapBlocks.mapBlockStates.WallBlock;

public class MapBlockStateBuilder {

    public function make(typeCode:MapBlockType, lifePoints:int = 1):IMapBlockState {
        switch (typeCode) {
            case MapBlockType.FREE:
                return new FreeBlock();
            case MapBlockType.BOX:
                return new BoxBlock();
            case MapBlockType.WALL:
                return new WallBlock();
            case MapBlockType.FRAGILE_WALL:
                return new FragileWallBlock(lifePoints);
            case MapBlockType.NULL:
                return NullMapBlock.getInstance();
        }
        throw new ArgumentError("Invalid Argument");
    }

    public function MapBlockStateBuilder() {
    }
}
}