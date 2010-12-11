/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers {
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.interfaces.IPlayerBomber;
import theGame.bombers.mapInfo.InputDirection;
import theGame.bombers.skin.BomberSkin;
import theGame.bombss.BombType;
import theGame.bombss.BombsBuilder;
import theGame.explosionss.interfaces.IExplosion;
import theGame.games.IGame;
import theGame.maps.interfaces.IBonus;
import theGame.playerColors.PlayerColor;
import theGame.utils.Direction;
import theGame.weapons.IWeapon;

public class PlayerBomber extends BomberBase implements IPlayerBomber {

    private var _direction:InputDirection;

    private var lastViewDir:Direction = Direction.NONE;
    /*
   * use BombersBuilder instead
   * */
    public function PlayerBomber(game:IGame, playerId:int, userName:String, color:PlayerColor, direction:InputDirection, skills:IGameSkills,weapon:IWeapon, skin:BomberSkin, bombBuilder:BombsBuilder) {
        super(game,playerId,userName,color,skills,weapon,skin,bombBuilder);

        _direction = direction;
    }

    public function performMotion(moveAmount:Number):void {
        if (_direction.direction == Direction.NONE)
            return;

        var x:int = _coords.getRealX();
        var y:int = _coords.getRealY();

        switch (_direction.direction) {
            case Direction.LEFT:
                _coords.stepLeft(moveAmount);
                checkViewHorDirectionChanged(x);
                break;
            case Direction.RIGHT:
                _coords.stepRight(moveAmount);
                checkViewHorDirectionChanged(x);
                break;
            case Direction.UP:
                _coords.stepUp(moveAmount);
                checkViewVertDirectionChanged(x);
                break;
            case Direction.DOWN:
                _coords.stepDown(moveAmount);
                checkViewVertDirectionChanged(x);
                break;
        }
        if (x != _coords.getRealX() || y != _coords.getRealY()) {
            game.playerCoordinatesChanged.dispatch(_coords.getRealX(), _coords.getRealY());
        } else if (lastViewDir != Direction.NONE) {
            lastViewDir = Direction.NONE;
            game.playerViewDirectionChanged.dispatch(_coords.getRealX(), _coords.getRealY(), Direction.NONE);
        }
    }

    private function checkViewHorDirectionChanged(oldX:int):void {
        if (_coords.getRealX() != oldX && lastViewDir != _direction.direction) {
            lastViewDir = _direction.direction;
            game.playerViewDirectionChanged.dispatch(_coords.getRealX(), _coords.getRealY(), _direction.direction);
        }
    }

    private function checkViewVertDirectionChanged(oldY:int):void {
        if (_coords.getRealY() != oldY && lastViewDir != _direction.direction) {
            lastViewDir = _direction.direction;
            game.playerViewDirectionChanged.dispatch(_coords.getRealX(), _coords.getRealY(), _direction.direction);
        }
    }

    private function viewDirectionChanged():Boolean {
        return (Direction.isHorizontal(_direction.direction) && _coords.yDef == 0) ||
                (Direction.isVertical(_direction.direction) && _coords.xDef == 0) ||
                (_direction.direction == Direction.NONE && lastViewDir != Direction.NONE );
    }

    private function updateInputDirection():void {
        _gameSkin.updateSkin(_direction.direction);

        var flag:Boolean = viewDirectionChanged();
        if (flag)
            lastViewDir = _direction.direction;
        game.playerInputDirectionChanged.dispatch(_coords.getRealX(), _coords.getRealY(), _direction.direction, flag);
    }


    private function startMotion():void {

    }

    private function endMotion():void {

    }

    public function addDirection(m:Direction):void {
        var dirBefore:Direction = _direction.direction;
        _direction.addDirection(m);

        if (_direction.hasAnyDirection())
            startMotion();

        if (dirBefore != _direction.direction) {
            updateInputDirection()
        }

    }

    public function removeDirection(m:Direction):void {
        var dirBefore:Direction = _direction.direction;
        _direction.removeDirection(m);
        if (!_direction.hasAnyDirection())
            endMotion();

        if (dirBefore != _direction.direction) {
            updateInputDirection();
        }
    }

    public function move(elapsedTime:Number):void {
        performMotion(elapsedTime * _skills.speed)
    }

    public function setBomb(bombType:BombType):void {
        if (_map.getBlock(coords.elemX, coords.elemY).canSetBomb() && _skills.bombCount > 0 && !isDead) {
            game.triedToSetBomb.dispatch(coords.elemX, coords.elemY, bombType);
        }
    }

    public function explode(expl:IExplosion = null):void {

        _life -= expl.damage;
        if(life < 0) life = 0;

        game.playerDamaged.dispatch(expl.damage, isDead)
        if (isDead) {
            game.playerDied.dispatch();
            return;
        }
        super.makeImmortalFor(_skills.immortalTime);
    }

    public function tryTakeBonus(bonus:IBonus):void {
        bonus.tryToTake();
        game.triedToTakeBonus.dispatch(bonus);
    }


    public function kill():void {
        game.playerDied.dispatch();
        game.playerDamaged.dispatch(_life, true);
        _life=0;
    }

    public function tryUseWeapon():void {
        if (!isDead && weapon.canActivateAt(_coords.elemX,_coords.elemY)) {
            game.triedToUseWeapon.dispatch(playerId,_coords.elemX,_coords.elemY,weapon.type);
        }
    }

    public function useWeapon():void {
        weapon.activateAt(_coords.elemX,coords.elemY,this);
    }

}
}