/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.mapInfo {
import theGame.utils.Direction;

public class InputDirection {

    private var dir1:Direction = Direction.NONE;
    private var dir2:Direction = Direction.NONE;

    private var lastDir:Direction = Direction.NONE;
    public var lastVertDir:Direction = Direction.NONE;
    public var lastHorDir:Direction = Direction.NONE;


    public function InputDirection() {

    }

    private function hasDir(move:Direction):Boolean {
        return dir1 == move || dir2 == move;
    }

    private function hasTwoDirs():Boolean {
        return dir1 != Direction.NONE && dir2 != Direction.NONE;
    }


    private function refresh():void {
        if (Direction.isVertical(dir1))
            lastVertDir = dir1;
        else
            lastHorDir = dir1;
        lastDir = dir1;
    }

    private function refreshHor():void {
        if (!Direction.isHorizontal(dir2) && !Direction.isHorizontal(dir1)) {
            resetHor();
        }
    }

    private function refreshVert():void {
        if (!Direction.isVertical(dir2) && !Direction.isVertical(dir1)) {
            resetVert();
        }
    }

    private function resetHor():void {
        lastHorDir = Direction.NONE;
    }

    private function resetVert():void {
        lastVertDir = Direction.NONE;
    }

    /*
     * returns true if new direction is the first one and bomber has to start motion
     * */
    public function addDirection(dir:Direction):void {

        if (hasDir(dir) || hasTwoDirs())
            return;

        if (hasAnyDirection())    //old motion is now motion2
        {
            dir2 = dir1;
            dir1 = dir;
        }
        else {
            dir1 = dir;
        }

        refresh();
    }

    /*
     * returns true if removed direction was the only one and bomber has to stop
     * */
    public function removeDirection(dir:Direction):void {

        if (dir2 == dir) {
            dir2 = Direction.NONE;
        }
        else if (dir1 == dir)
            if (dir2 != Direction.NONE) {
                dir1 = dir2;
                dir2 = Direction.NONE;
            } else {
                dir1 = Direction.NONE;
            }
        if (Direction.isHorizontal(dir))
            refreshHor();
        else
            refreshVert();

    }

    public function hasAnyDirection():Boolean {
        return dir1 != Direction.NONE;
    }

    public function get direction():Direction {
        return dir1;
    }


}
}