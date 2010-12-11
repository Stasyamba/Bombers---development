/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers {
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.skin.BomberSkin;
import theGame.bombers.skin.GameSkin;
import theGame.bombss.BombsBuilder;
import theGame.data.Consts;
import theGame.explosionss.interfaces.IExplosion;
import theGame.games.IGame;
import theGame.playerColors.PlayerColor;
import theGame.utils.Direction;
import theGame.weapons.IWeapon;

public class EnemyBomber extends BomberBase implements IEnemyBomber {

    protected var _direction:Direction = Direction.NONE;

    public function EnemyBomber(game:IGame, playerId:int, userName:String, bombBuilder:BombsBuilder, skills:IGameSkills,weapon:IWeapon, skin:BomberSkin, color:PlayerColor) {
        super(game,playerId,userName,color,skills,weapon,skin,bombBuilder);

        game.enemyInputDirectionChanged.add(directionChanged);
        game.enemyDamaged.add(onDamaged);
        game.enemyDied.add(onDied);
    }

    private function onDied(id:int):void {
        if(id == playerId)
            kill();
    }

    protected function onDamaged(id:int, health_left:int):void {
        if (playerId == id) {
            _life = health_left;
            makeImmortalFor(_skills.immortalTime);
        }
    }

    protected function directionChanged(id:int, x:Number, y:Number, dir:Direction):void {
        if (id != playerId)
            return;

        _coords.elemX = int(x / Consts.BLOCK_SIZE);
        _coords.xDef = x % Consts.BLOCK_SIZE;

        _coords.elemY = int(y / Consts.BLOCK_SIZE);
        _coords.yDef = y % Consts.BLOCK_SIZE;

        _gameSkin.updateSkin(dir);
        _direction = dir;
    }

    public function performSmoothMotion(moveAmount:Number):void {
        switch (_direction) {
            case Direction.NONE:
                return;
            case Direction.LEFT:
                _coords.stepLeft(moveAmount);
                break;
            case Direction.RIGHT:
                _coords.stepRight(moveAmount);
                break;
            case Direction.UP:
                _coords.stepUp(moveAmount);
                break;
            case Direction.DOWN:
                _coords.stepDown(moveAmount);
                break;
        }
        game.enemySmoothMovePerformed.dispatch(playerId, _coords.getRealX(), _coords.getRealY());
    }

    public function move(elapsedTime:Number):void {
        performSmoothMotion(elapsedTime * _skills.speed);
    }

    public function kill():void {
        _life = 0;
    }

    public function useWeapon():void {
        weapon.activateAt(_coords.elemX,coords.elemY,this);
    }

    public function explode(expl:IExplosion = null):void {
    }
}
}