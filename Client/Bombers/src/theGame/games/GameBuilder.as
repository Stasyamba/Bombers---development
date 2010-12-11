/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.games {
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;

import theGame.playerColors.PlayerColor;

public class GameBuilder {
    public function GameBuilder() {
    }

    private function getColor(playerId:int):PlayerColor {
        switch (playerId) {
            case 4:
                return PlayerColor.BLUE;
            case 3:
                return PlayerColor.ORANGE;
            case 1:
                return PlayerColor.PINK;
            case 2:
                return PlayerColor.RED;

        }
        throw new Error("No more colors")
    }

    public function makeFromRoom(room:Room, mapId:int, spawnData:Array):IGame {
        var gameType:GameType = GameType.fromValue(room.getVariable('gameType').getStringValue());
        switch (gameType) {
            case GameType.REGULAR:
                var game:RegularGame = new RegularGame();
                for each (var user:User in room.userList) {
                    if (!user.isPlayer)
                        continue;
                    game.addPlayer(user, getColor(user.playerId))
                }
                game.applyMap(mapId, spawnData)
                return game;
        }
        throw new ArgumentError("invalid gameType");
    }


    public function makeSinglePlayer(gameType:GameType, mapId:int):IGame {
        switch (gameType) {
            case GameType.SINGLE:
                var game:SinglePlayerGame = new SinglePlayerGame();
                game.addPlayer(Context.gameServer.mySelf, getColor(1))
                game.addBot(getColor(2))
                game.addBot(getColor(3))
                game.addBot(getColor(4))
                game.applyMap(mapId)
                return game;
        }
        throw new ArgumentError("invalid gameType");
    }
}
}