/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps {
import mx.collections.ArrayList;
import mx.controls.Alert;

import theGame.data.location1.mapObjects.BigObjects;
import theGame.maps.bigObjects.BigObject;
import theGame.maps.builders.MapBlockBuilder;
import theGame.maps.interfaces.IBigObject;
import theGame.maps.interfaces.IMapBlock;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.utils.Direction;

public class Map implements IMap {

    public var blockBuilder:MapBlockBuilder;

    private var _blocks:Vector.<IMapBlock>;

    private var _bigObjects:Vector.<IBigObject> = new Vector.<IBigObject>;

    private var _width:uint;
    private var _height:uint;
    private var _spawns:Array = new Array();

    private var _explosionPrints:ArrayList = new ArrayList();

    //blockBuilder is injected via mapBuilder
    public function Map(xml:XML, blockBuilder:MapBlockBuilder) {
        this.blockBuilder = blockBuilder;
        fill(xml);
    }

    public function getBlock(x:uint, y:uint):IMapBlock {
        if (!areCoordsOk(x, y))
            throw new ArgumentError("One of indexes is out of range.");
        return _blocks[index(x, y)];
    }

    private function areCoordsOk(x:uint, y:uint):Boolean {
        return !(x >= width || y >= height || x < 0 || y < 0);
    }

    public function fill(xml:XML):void {

        _width = xml.size.@width;
        _height = xml.size.@height;

        _blocks = new Vector.<IMapBlock>(_width * _height, true);

        var y:int = 0;
        for each (var rowXml:XML in xml.rows.Row) {
            var rowStr:String = rowXml.@val;
            for (var x:int = 0; x < rowStr.length; x++) {
                try {
                    _blocks[index(x, y)] = blockBuilder.make(x, y, MapBlockType.fromChar(rowStr.charCodeAt(x)));
                } catch(er:ArgumentError) {
                    Alert.show("String contains bad symbols");
                }
            }
            y++;
        }
        for each (var bObj:XML in xml.bigObjects.BigObject) {
            bigObjects.push(new BigObject(bObj.@x, bObj.@y, BigObjects.objects[String(bObj.@id)]));
        }
        for each (var spawn:XML in xml.spawns.Spawn) {
            _spawns.push({x:spawn.@x,y:spawn.@y})
        }
    }

    private function index(x:int, y:int):int {
        return  y * width + x;
    }

    public function getNeighbour(ofX:int, ofY:int, to:Direction):IMapBlock {
        if (!areCoordsOk(ofX, ofY))
            return blockBuilder.make(0, 0, MapBlockType.NULL);
        switch (to) {
            case Direction.LEFT:
                return getLeft(ofX, ofY);
            case Direction.RIGHT:
                return getRight(ofX, ofY);
            case Direction.UP:
                return getUp(ofX, ofY);
            case Direction.DOWN:
                return getDown(ofX, ofY);
        }
        throw new ArgumentError("Invalid neighbour direction");
    }

    private function getLeft(ofX:int, ofY:int):IMapBlock {
        if (ofX == 0)
            return blockBuilder.make(0, 0, MapBlockType.NULL);
        return getBlock(ofX - 1, ofY);
    }

    private function getRight(ofX:int, ofY:int):IMapBlock {
        if (ofX == width - 1)
            return blockBuilder.make(0, 0, MapBlockType.NULL);
        return getBlock(ofX + 1, ofY);
    }

    private function getUp(ofX:int, ofY:int):IMapBlock {
        if (ofY == 0)
            return blockBuilder.make(0, 0, MapBlockType.NULL);
        return getBlock(ofX, ofY - 1);
    }

    private function getDown(ofX:int, ofY:int):IMapBlock {
        if (ofY == height - 1)
            return blockBuilder.make(0, 0, MapBlockType.NULL);
        return getBlock(ofX, ofY + 1);
    }

    //getters
    public function get width():uint {
        return _width;
    }

    public function get height():uint {
        return _height;
    }

    public function get blockCount():uint {
        return _blocks.length;
    }

    public function get blocks():Vector.<IMapBlock> {
        return _blocks;
    }

    public function get bigObjects():Vector.<IBigObject> {
        return _bigObjects;
    }

    public function get spawns():Array {
        return _spawns;
    }

    public function validPoint(x:int, y:int):Boolean {
        return (x >= 0) && (y >= 0) && (x < width) && (y < height);
    }

    public function get explosionPrints():ArrayList {
        return _explosionPrints;
    }
}
}