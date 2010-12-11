/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.profiles.interfaces {
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.skin.BomberSkin;

public interface IGameProfile {
    function get name():String;

    function getGameSkills():IGameSkills;

    function getSkin(playerId:int):BomberSkin;
}
}