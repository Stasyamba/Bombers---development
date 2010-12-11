/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.interfaces {
import flash.display.Sprite;

import theGame.bombers.skin.BomberSkin;
import theGame.bombers.skin.SkinElement;
import theGame.playerColors.PlayerColor;
import theGame.utils.Direction;

public interface IGameSkin {
    function updateSkin(dir:Direction):void;

    function get color():PlayerColor;

    function set color(playerColor:PlayerColor):void;

    function get skin():BomberSkin;

    function get currentSkin():SkinElement;

    function get currentMask():Sprite;
}
}