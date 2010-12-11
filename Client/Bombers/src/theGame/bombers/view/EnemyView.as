/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.view {
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.interfaces.IDestroyable;
import theGame.utils.Direction;

public class EnemyView extends BomberViewBase implements IDestroyable {

    public function EnemyView(bomber:IEnemyBomber) {
        super(bomber);
        Context.game.enemyInputDirectionChanged.add(inputDirectionChanged);
        Context.game.enemySmoothMovePerformed.add(updateCoords)
        Context.game.enemyDied.add(onEnemyDied);
    }

    private function inputDirectionChanged(id:int, x:Number, y:Number, dir:Direction):void {
        if (id == bomber.playerId && !bomber.isDead) {
            this.x = x;
            this.y = y;
            draw();
        }
    }

    private function updateCoords(id:int, x:int, y:int):void {

        if (id == bomber.playerId && !bomber.isDead) {
            this.x = x;
            this.y = y;
        }
    }

    private function get bomber():IEnemyBomber {
        return _bomber as IEnemyBomber;
    }

    public function destroy():void {
        Context.game.enemyInputDirectionChanged.remove(inputDirectionChanged);
        Context.game.enemySmoothMovePerformed.remove(updateCoords)
        Context.game.enemyDied.remove(onEnemyDied);
    }

    protected function onEnemyDied(id:int):void {
        if (id == _bomber.playerId) {
            onDied();
            destroy();
        }
    }
}
}