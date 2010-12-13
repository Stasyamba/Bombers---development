/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.playerColors {
import flash.display.BitmapData;

import theGame.data.location1.bombs.Bombs;

public class PlayerColor {

    private var _key:String;
    private var _bombGlow:BitmapData;
    private var _color:uint;

    public static const BLUE:PlayerColor = new PlayerColor("blue", Bombs.BLUE_GLOW, 0x1145c7);
    public static const ORANGE:PlayerColor = new PlayerColor("orange", Bombs.ORANGE_GLOW, 0xff6600);
    public static const PINK:PlayerColor = new PlayerColor("pink", Bombs.PINK_GLOW, 0xFF00FF);
    public static const RED:PlayerColor = new PlayerColor("red", Bombs.RED_GLOW, 0xFF0000);

    public function PlayerColor(key:String, bombGlow:BitmapData, color:uint) {
        _key = key;
        _bombGlow = bombGlow;
        _color = color;
    }

    public function get key():String {
        return _key;
    }

    public function get bombGlow():BitmapData {
        return _bombGlow;
    }

    public function get color():uint {
        return _color;
    }
}
}