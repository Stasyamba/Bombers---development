/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.bombers.skin {
import flash.display.Bitmap;

public class BomberSkin {

    public var name:String
    public var skinElements:Object;
    public var colors:Object;

    //    public var left:SkinElement;
    //    public var right:SkinElement;
    //    public var up:SkinElement;
    //    public var down:SkinElement;
    //    public var none:SkinElement;
    //
    //    private var _color:uint = 0;
    
    public function BomberSkin(name:String, skinElements:Object, colors:Object) {
        this.name = name;
        this.skinElements = skinElements;
        this.colors = colors;
    }
}
}