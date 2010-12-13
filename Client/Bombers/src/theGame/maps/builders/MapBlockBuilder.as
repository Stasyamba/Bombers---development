/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.builders {
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapBlocks.MapBlock;
import theGame.maps.mapBlocks.MapBlockType;

public class MapBlockBuilder {

    public var mapBlockStateBuilder:MapBlockStateBuilder;
    public var mapObjectBuilder:MapObjectBuilder;

    public function MapBlockBuilder(mapBlockTypeBuilder:MapBlockStateBuilder, mapObjectBuilder:MapObjectBuilder) {
        this.mapBlockStateBuilder = mapBlockTypeBuilder;
        this.mapObjectBuilder = mapObjectBuilder;
    }

    public function make(x:int, y:int, type:MapBlockType):IMapBlock {
        return new MapBlock(x, y, mapBlockStateBuilder.make(type), mapBlockStateBuilder, mapObjectBuilder);
    }
}
}