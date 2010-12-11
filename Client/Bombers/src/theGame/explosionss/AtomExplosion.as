/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.explosionss {
import theGame.explosionss.interfaces.IExplosion;
import theGame.maps.IMap;
import theGame.model.explosionss.ExplosionType;

public class AtomExplosion extends ExplosionBase implements IExplosion {

    private static const BRANCH_LENGTH:int = 2;

    public function AtomExplosion(map:IMap, centerX:int = -1, centerY:int = -1) {
        super(map, centerX, centerY)
        timeToLive = type.timeToLive
    }

    private function addHorBranches(y:int):void {
        var firstSet:Boolean = false;

        addPoint(new ExplosionPoint(centerX, y, ExplosionPointType.CROSS));

        for (var i:int = -BRANCH_LENGTH; i < 0; i++) {
            if (map.validPoint(centerX + i, y)) {
                if (!firstSet) {
                    addPoint(new ExplosionPoint(centerX + i, y, ExplosionPointType.LEFT))
                    firstSet = true;
                }
                else
                    addPoint(new ExplosionPoint(centerX + i, y, ExplosionPointType.HORIZONTAL))
            }
        }

        firstSet = false;
        for (i = BRANCH_LENGTH; i > 0; i--) {
            if (map.validPoint(centerX + i, y)) {
                if (!firstSet) {
                    addPoint(new ExplosionPoint(centerX + i, y, ExplosionPointType.RIGHT))
                    firstSet = true;
                }
                else
                    addPoint(new ExplosionPoint(centerX + i, y, ExplosionPointType.HORIZONTAL))
            }
        }
    }

    private function addVertBranches(x:int):void {

        var firstSet:Boolean = false;

        addPoint(new ExplosionPoint(x, centerY, ExplosionPointType.CROSS));

        for (var i:int = -BRANCH_LENGTH; i < 0; i++) {
            if (map.validPoint(x, centerY + i)) {
                if (!firstSet) {
                    addPoint(new ExplosionPoint(x, centerY + i, ExplosionPointType.UP))
                    firstSet = true;
                }
                else
                    addPoint(new ExplosionPoint(x, centerY + i, ExplosionPointType.VERTICAL))
            }
        }

        firstSet = false;
        for (i = BRANCH_LENGTH; i > 0; i--) {
            if (map.validPoint(x, centerY + i)) {
                if (!firstSet) {
                    addPoint(new ExplosionPoint(x, centerY + i, ExplosionPointType.DOWN))
                    firstSet = true;
                }
                else
                    addPoint(new ExplosionPoint(x, centerY + i, ExplosionPointType.VERTICAL))
            }
        }
    }

    private function needVertBranches(x:int):Boolean {
        return (Math.abs(x - centerX) > 2) &&
                (Math.abs(x - centerX) % 3 == 0);
    }

    private function needHorBranches(y:int):Boolean {
        return (Math.abs(y - centerY) > 2) &&
                (Math.abs(y - centerY) % 3 == 0);
    }

    public function perform():void {
        addPoint(new ExplosionPoint(centerX, centerY, ExplosionPointType.CROSS));
        var x:int,y:int;

        //x-line
        for (x = 0; x < map.width; x++) {
            if (needVertBranches(x))
                addVertBranches(x);
            else
                switch (x) {
                    case 0:
                        addPoint(new ExplosionPoint(0, centerY, ExplosionPointType.LEFT))
                        break;
                    case map.width - 1:
                        addPoint(new ExplosionPoint(map.width - 1, centerY, ExplosionPointType.RIGHT))
                        break;
                    default:
                        addPoint(new ExplosionPoint(x, centerY, ExplosionPointType.HORIZONTAL))
                }
        }
        //y-line
        for (y = 0; y < map.height; y++) {
            if (needHorBranches(y))
                addHorBranches(y);
            else
                switch (y) {
                    case 0:
                        addPoint(new ExplosionPoint(centerX, 0, ExplosionPointType.UP))
                        break;
                    case map.height - 1:
                        addPoint(new ExplosionPoint(centerX, map.height - 1, ExplosionPointType.DOWN))
                        break;
                    default:
                        addPoint(new ExplosionPoint(centerX, y, ExplosionPointType.VERTICAL))
                }
        }

    }

    public function get type():ExplosionType {
        return ExplosionType.ATOM;
    }

    public function get damage():int {
        return 1;
    }
}
}