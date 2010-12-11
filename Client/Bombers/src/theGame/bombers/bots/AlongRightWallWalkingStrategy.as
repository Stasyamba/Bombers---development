/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.bots {
import theGame.bombers.interfaces.IMapCoords;
import theGame.utils.Direction;

public class AlongRightWallWalkingStrategy implements IWalkingStrategy {

    public function AlongRightWallWalkingStrategy() {
        super();
    }

    public function getDirection(dir:Direction, coords:IMapCoords):Direction {
        switch (dir) {
            case Direction.LEFT:
                if (coords.canMoveUp()) return Direction.UP;
                if (coords.canMoveLeft()) return Direction.LEFT;
                if (coords.canMoveDown()) return Direction.DOWN;
                return Direction.RIGHT;
            case Direction.DOWN:
                if (coords.canMoveLeft()) return Direction.LEFT;
                if (coords.canMoveDown()) return Direction.DOWN;
                if (coords.canMoveRight()) return Direction.RIGHT;
                return Direction.UP;
            case Direction.RIGHT:
                if (coords.canMoveDown()) return Direction.DOWN;
                if (coords.canMoveRight()) return Direction.RIGHT;
                if (coords.canMoveUp()) return Direction.UP;
                return Direction.LEFT;
            case Direction.UP:
                if (coords.canMoveRight()) return Direction.RIGHT;
                if (coords.canMoveUp()) return Direction.UP;
                if (coords.canMoveLeft()) return Direction.LEFT;
                return Direction.DOWN;
            case Direction.NONE:
                if (coords.canMoveRight()) return Direction.RIGHT;
                if (coords.canMoveUp()) return Direction.UP;
                if (coords.canMoveLeft()) return Direction.LEFT;
                return Direction.DOWN;
        }
        throw new ArgumentError("invalid dir");
    }
}
}