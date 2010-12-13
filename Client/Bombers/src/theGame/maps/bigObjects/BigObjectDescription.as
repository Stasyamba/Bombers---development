/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.bigObjects {
import theGame.maps.interfaces.IBigObjectDescription;

public class BigObjectDescription implements IBigObjectDescription {

    private var _id:String;
    private var _width:int;
    private var _height:int;
    private var _defaultLife:int;
    private var _blocks:Array = new Array();
    private var _skin:String;

    public function BigObjectDescription(xml:XML) {
        _id = xml.id.@val;
        _width = xml.width.@val;
        _height = xml.height.@val;
        _defaultLife = xml.defaultLife.@val;
        _skin = xml.skin.@val
        for each (var block:XML in xml.blocks.ObjectBlock) {
            var b:Object = new Object();
            b.x = block.@x;
            b.y = block.@y;
            b.canGoThrough = block.@canGoThrough;
            b.canSetBomb = block.@canSetBomb
            b.canExplosionGoThrough = block.@canExplosionGoThrough
            b.explodesAndStopsExplosion = block.@explodesAndStopsExplosion
            b.typeAfterObjectDestroyed = block.@typeAfterObjectDestroyed
            b.objectAfterObjectDestroyed = block.@objectAfterObjectDestroyed
            b.explodes = block.@explodes
            _blocks.push(b);
        }
    }

    public function get width():int {
        return _width;
    }

    public function get height():int {
        return _height;
    }

    public function get defaultLife():int {
        return _defaultLife;
    }

    public function get skin():String {
        return _skin;
    }

    public function get id():String {
        return _id;
    }

    public function get blocks():Array {
        return _blocks;
    }
}
}