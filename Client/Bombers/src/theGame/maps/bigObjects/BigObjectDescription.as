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
    private var _states:Array = new Array;

    public function BigObjectDescription(xml:XML) {
        _id = xml.id;
        _width = xml.width;
        _height = xml.height;
        _defaultLife = xml.defaultLife;
        for each (var state:XML in xml.states.State) {
            _states[state.@life] = state.@skin;
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

    public function get states():Array {
        return _states;
    }

    public function get id():String {
        return _id;
    }

    public function get defaultState():String {
        return states[defaultLife];
    }
}
}