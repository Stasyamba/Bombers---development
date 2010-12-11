package theGame.model.managers.interfaces {
import theGame.bombers.interfaces.IBomber;
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.explosionss.interfaces.IExplosion;

public interface IEnemiesManager {
    /*
     * Function must look like this:
     * function do(item:IEnemyBomber, playerId:int):void;
     * */
    function forEachAliveEnemy(todo:Function):void;

    function moveEnemies(elapsedMiliSecs:int):void;

    function addEnemy(enemy:IEnemyBomber):void;

    function getEnemyById(playerId:int):IEnemyBomber;

    function hasEnemy(playerId:int):Boolean;

    function get enemiesCount():int;

    function checkEnemiesMetExplosion(e:IExplosion):void;
}
}