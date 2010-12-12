/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.maps.interfaces {
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.mapBlocks.MapBlockType;
import theGame.model.explosionss.ExplosionType;

public interface IMapBlockState {

    function explodesAndStopsExplosion():Boolean

    function canGoThrough():Boolean;

    function canSetBomb():Boolean;

    function canExplosionGoThrough():Boolean

    function canHaveExplosionPrint(explType:ExplosionType):Boolean;

    function explode(expl:IExplosion):void;

    function get type():MapBlockType;

    function stateAfterExplosion(expl:IExplosion):MapBlockType;

    function get canShowObjects():Boolean;

    function get hiddenObject():IMapObject;

    function set hiddenObject(value:IMapObject):void ;
}
}