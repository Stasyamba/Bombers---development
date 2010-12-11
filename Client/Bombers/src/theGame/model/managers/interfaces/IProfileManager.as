/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.model.managers.interfaces {
import theGame.bombers.interfaces.IGameSkin;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.skin.BomberSkin;

public interface IProfileManager {

    function get name():String;

    function getMapSkills():IGameSkills;

    function getSkin():BomberSkin;
}
}