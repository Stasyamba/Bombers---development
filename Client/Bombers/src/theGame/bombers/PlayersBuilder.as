/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers {
import theGame.bombers.bots.IWalkingStrategy;
import theGame.bombers.interfaces.IEnemyBomber;
import theGame.bombers.interfaces.IMapCoords;
import theGame.bombers.interfaces.IGameSkills;
import theGame.bombers.interfaces.IPlayerBomber;
import theGame.bombers.mapInfo.InputDirection;
import theGame.bombers.mapInfo.MapCoords;
import theGame.bombers.skin.BomberSkin;
import theGame.bombss.BombsBuilder;
import theGame.games.IGame;
import theGame.maps.IMap;
import theGame.model.managers.interfaces.IProfileManager;
import theGame.model.managers.regular.MapManager;
import theGame.playerColors.PlayerColor;
import theGame.profiles.interfaces.IGameProfile;
import theGame.weapons.IWeapon;

public class PlayersBuilder {

    private var bombsBuilder:BombsBuilder;


    public function makePlayer(game:IGame,playerId:int,name:String,color:PlayerColor,skills:IGameSkills,weapon:IWeapon,skin:BomberSkin):IPlayerBomber {
        var inputDirection:InputDirection = new InputDirection();

        return new PlayerBomber(game,playerId,name,color,inputDirection, skills,weapon, skin,bombsBuilder)
    }

    public function makeEnemy(game:IGame,playerId:int, name:String, color:PlayerColor, skills:IGameSkills,weapon:IWeapon, skin:BomberSkin):IEnemyBomber {
        return new EnemyBomber(game,playerId, name, bombsBuilder, skills,weapon, skin, color);
    }

    public function makeEnemyBot(game:IGame,playerId:int, name:String, color:PlayerColor, skills:IGameSkills,weapon:IWeapon, skin:BomberSkin,walkingStrategy:IWalkingStrategy):IEnemyBomber {
        return new BotEnemyBomber(game,playerId, name, bombsBuilder, skills,weapon, skin, color,walkingStrategy);
    }


    public function PlayersBuilder(bombsBuilder:BombsBuilder) {
        this.bombsBuilder = bombsBuilder;
    }
}
}