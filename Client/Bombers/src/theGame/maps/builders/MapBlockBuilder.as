/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.builders {
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapBlocks.MapBlock;
import theGame.maps.mapBlocks.MapBlockType;

public class MapBlockBuilder {

    private var mapBlockTypeBuilder:MapBlockStateBuilder;
    private var mapObjectBuilder:MapObjectBuilder;

    public function MapBlockBuilder(mapBlockTypeBuilder:MapBlockStateBuilder, mapObjectBuilder:MapObjectBuilder) {
        this.mapBlockTypeBuilder = mapBlockTypeBuilder;
        this.mapObjectBuilder = mapObjectBuilder;
    }

    public function make(x:int, y:int, type:MapBlockType):IMapBlock {
        return new MapBlock(x, y, mapBlockTypeBuilder.make(type), mapBlockTypeBuilder, mapObjectBuilder);
    }
}
}