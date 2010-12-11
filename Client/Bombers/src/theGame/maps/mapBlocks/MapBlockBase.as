/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.mapBlocks {
import org.osflash.signals.Signal;

import theGame.maps.interfaces.IMapBlockState;

public class MapBlockBase {
    public function MapBlockBase() {
    }

    protected var _viewUpdated:Signal = new Signal();
    private var _explosionStarted:Signal = new Signal();
    private var _explosionStopped:Signal = new Signal();

    public function get viewUpdated():Signal {
        return _viewUpdated;
    }

    public function get explosionStarted():Signal {
        return _explosionStarted;
    }

    public function get explosionStopped():Signal {
        return _explosionStopped;
    }

    protected var _x:int;
    protected var _y:int;
    protected var _state:IMapBlockState;

    public function get type():MapBlockType {
        return state.type;
    }

    public function get state():IMapBlockState {
        return _state;
    }

    public function get x():int {
        return _x;
    }

    public function get y():int {
        return _y;
    }
}
}