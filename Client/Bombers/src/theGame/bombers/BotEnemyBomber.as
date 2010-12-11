/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers {
import theGame.bombers.bots.IWalkingStrategy;
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.skin.BomberSkin;
import theGame.bombss.BombsBuilder;
import theGame.games.IGame;
import theGame.playerColors.PlayerColor;
import theGame.utils.Direction;
import theGame.weapons.IWeapon;

public class BotEnemyBomber extends EnemyBomber implements IEnemyBomber {

    private var walkingStrategy:IWalkingStrategy;

    public function BotEnemyBomber(game:IGame, playerId:int, userName:String, bombBuilder:BombsBuilder, skills:IGameSkills, weapon:IWeapon, skin:BomberSkin, color:PlayerColor, walkingStrategy:IWalkingStrategy) {
        super(game, playerId, userName, bombBuilder, skills, weapon, skin, color)

        this.walkingStrategy = walkingStrategy;
    }

    public override function move(elapsedTime:Number):void {
        var willCover:Number = elapsedTime * _skills.speed;
        if (willGetToBlockCenter(willCover)) {
            var d:Direction = walkingStrategy.getDirection(_direction, _coords);
            if (d != _direction)
                game.enemyInputDirectionChanged.dispatch(playerId, _coords.getRealX(), _coords.getRealY(), d);
        }
        super.move(elapsedTime);
    }

    private function willGetToBlockCenter(willCover:Number):Boolean {
        switch (_direction) {
            case Direction.LEFT:
                return (coords.xDef > 0 && Math.abs(coords.xDef) < willCover)
            case Direction.RIGHT:
                return (coords.xDef < 0 && Math.abs(coords.xDef) < willCover)
            case Direction.UP:
                return (coords.yDef > 0 && Math.abs(coords.yDef) < willCover)
            case Direction.DOWN:
                return (coords.yDef < 0 && Math.abs(coords.yDef) < willCover)
        }
        return true;
    }

}
}