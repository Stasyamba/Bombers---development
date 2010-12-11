package components.wall {
public class PostID {
    public static const TYPE_VKURL:int = 0;
    public static const TYPE_RUSENGTEXT:int = 1;
    public static const TYPE_SIMPLE:int = 2;


    /* SYMBOLS FOR VKURL CODING */
    public static const DOT_DELIMETR:String = "dot";
    public static const LOW_LINE_DELIMETER:String = "line";
    public static const SLASHES_DELIMETER:String = "slashes";
    public static const PREAMBULA:String = "http:\/\/";

    /* SYMBOLS FOR RUSENG TEXT CODING */
    public static const CRYPT_SYMBOL:String = "8";
    public static const NATIVE_SYMBOL:String = "9";


    public static const ID_DELIMETER:String = "huyhuyhuy";


    public static function encode(source:String, type:int):String {
        var res:String = "";

        source = source.toLowerCase();


        switch (type) {
            case TYPE_VKURL:

                // http:\/\/cs10393.vkontakte.ru\/u19180\/c_484ecf54.jpg

                res = source;
                res = res.slice(PREAMBULA.length, source.length);
                res = res.replace(/(\/)/g, SLASHES_DELIMETER);
                res = res.replace(/_/g, LOW_LINE_DELIMETER);
                res = res.replace(/\./g, DOT_DELIMETR);

                break;
            case TYPE_RUSENGTEXT:

                var rus:String = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
                var eng:String = "abcdefghijklmpopqrstuvwxyz1234567";

                for (var i:int = 0; i <= source.length - 1; i++) {
                    var isRussian:Boolean = false;

                    for (var j:int = 0; j <= rus.length - 1; j++) {
                        if (source.charAt(i) == rus.charAt(j)) {
                            res += CRYPT_SYMBOL + eng.charAt(j);
                            isRussian = true;
                            break;
                        }
                    }

                    if (!isRussian) {
                        res += NATIVE_SYMBOL + source.charAt(i);
                    }
                }

                break;
            case TYPE_SIMPLE:
                res = source;
                break;
            default:
                break;
        }

        return res;
    }

    public static function decode(source:String, type:int):String {
        var res:String = "";

        switch (type) {
            case TYPE_VKURL:

                // http:\/\/cs10393.vkontakte.ru\/u19180\/c_484ecf54.jpg

                res = PREAMBULA;
                var fixed:String = source;

                fixed = fixed.replace(/(slashes)/g, "\/");
                fixed = fixed.replace(/(line)/g, "_");
                fixed = fixed.replace(/(dot)/g, ".");

                res += fixed;

                break;
            case TYPE_RUSENGTEXT:

                var rus:String = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
                var eng:String = "abcdefghijklmpopqrstuvwxyz1234567";

                for (var i:int = 0; i <= source.length - 1; i += 2) {
                    if (source.charAt(i) == CRYPT_SYMBOL) {
                        var index:int = -1;
                        for (var j:int = 0; j <= eng.length - 1; j++) {
                            if (eng.charAt(j) == source.charAt(i + 1)) {
                                index = j;
                                break;
                            }
                        }

                        if (index != -1) {
                            res += rus.charAt(index);
                        }
                    } else if (source.charAt(i) == NATIVE_SYMBOL) {
                        res += source.charAt(i + 1);
                    }
                }

                break;
            case TYPE_SIMPLE:
                res = source;
                break;
            default:
                break;
        }

        return res;
    }

}
}