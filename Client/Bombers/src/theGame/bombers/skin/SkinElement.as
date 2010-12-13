/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.skin {
import flash.display.Bitmap;

public class SkinElement {

    public var skin:Bitmap;
    public var mask:Bitmap;

    public function SkinElement(skin:Bitmap, mask:Bitmap) {
        this.skin = skin;
        this.mask = mask;
    }


}
}