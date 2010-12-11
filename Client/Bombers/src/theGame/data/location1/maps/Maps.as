/*
 * Copyright (c) 2010.
 * Pavkin Vladimir
 */

package theGame.data.location1.maps {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;

public class Maps {
    private static var uLoader:URLLoader = new URLLoader();

    [Embed(source="testSingle.xml",mimeType="application/octet-stream")]
    public static const TEST_SINGLE:Class;
    public static const TEST_SINGLE_ID:int = 11;

    public static const mapClasses:Array = [TEST_SINGLE];

    private static var _mapXmls:Array;

    public static function get mapXmls():Array {
        if (_mapXmls == null) {
            _mapXmls = new Array();

            var file:ByteArray = new TEST_SINGLE();
            var str:String = file.readUTFBytes(file.length);
            _mapXmls[TEST_SINGLE_ID] = new XML(str);

        }
        return _mapXmls;
    }

    public static function getXmlById(mapId:int):XML {

        if(mapXmls[mapId] != null){
            return mapXmls[mapId];
        }
        uLoader.load(new URLRequest("http://cs1.vensella.ru:8080/bombers_maps/map" + mapId + ".xml?123"))
        if(!uLoader.hasEventListener(Event.COMPLETE))
            uLoader.addEventListener(Event.COMPLETE, u_completeHandler);
        return null;
    }

    private static function u_completeHandler(event:Event):void {
        //var file:ByteArray = uLoader.data as ByteArray;
         //file.readUTFBytes(file.length);
        var str:String = uLoader.data as String;
        var xml:XML = new XML(str);
        
        var id:int = xml.id.@val;
        mapXmls[id] = xml;
        Context.gameModel.mapLoaded.dispatch(xml)
    }
}
}