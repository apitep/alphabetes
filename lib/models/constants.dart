import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Constants {
  //App related strings
  static String appName = "Je lis";

  final Color kColorBlueMedincell = Color(0xFF4d9cd5);
  final Color kColorLightGray = Color(0xFFececec);

  static const String kTitle = "Alphabêtes";

  static const String kUrlRemoteData = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/data/";
  static const String kUrlImages = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/images/";
  static const String kUrlRewards = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/data/rewards.json";
  static const String kUrlApplause = "https://raw.githubusercontent.com/apitep/alphabetes/master/remotedata/sounds/applause.mp3";
  static const String kDefaultUrlReward = "https://raw.githubusercontent.com/EricNahon/pikatchuTesOu/master/remotedata/images/Bulbasaur.gif";

  final Widget kApitepLogo = Image.asset('assets/images/ApitepBearLogo.png', height: 100);
  final Widget kVictoryBadge = Image.asset('assets/images/VictoryBadge.png', height: 35);

  //Colors for theme
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff2B2B2B);
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 1,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {"title": "Downloads", "icon": Feather.download, "path": "", "color": Colors.purple},
    {"title": "Images", "icon": Feather.image, "path": "", "color": Colors.blue},
    {"title": "Videos", "icon": Feather.video, "path": "", "color": Colors.red},
    {"title": "Audio", "icon": Feather.headphones, "path": "", "color": Colors.teal},
    {"title": "Documents & Others", "icon": Feather.file, "path": "", "color": Colors.pink},
    {"title": "Apps", "icon": Icons.android, "path": "", "color": Colors.green},
    {"title": "Whatsapp Statuses", "icon": FontAwesome.whatsapp, "path": "", "color": Colors.green},
  ];

  static List sortList = [
    "File name (A to Z)",
    "File name (Z to A)",
    "Date (oldest first)",
    "Date (newest first)",
    "Size (largest first)",
    "Size (Smallest first)",
  ];

  static Map<String, String> languages = {
    'fr': 'fr-FR',
    'gb': 'en-GB',
    'nl': 'nl-NL',
    'es': 'es-ES',
  };

  static Map<String, String> languageNames = {
    'ab': 'Abchasisch',
    'aa': 'Afar',
    'af': 'Afrikaans',
    'ak': 'Akan',
    'sq': 'Albanisch',
    'am': 'Amharisch',
    'ar': 'Arabisch',
    'an': 'Aragonesisch',
    'hy': 'Armenisch',
    'as': 'Assamesisch',
    'av': 'Avarisch',
    'ae': 'Avestisch',
    'ay': 'Aymara',
    'az': 'Aserbaidschanisch',
    'bm': 'Bambara',
    'ba': 'Baschkirisch',
    'eu': 'Baskisch',
    'be': 'Weißrussisch',
    'bn': 'Bengalisch',
    'bh': 'Bihari',
    'bi': 'Bislama',
    'bs': 'Bosnisch',
    'br': 'Bretonisch',
    'bg': 'Bulgarisch',
    'my': 'Birmanisch',
    'ca': 'Katalanisch, Valencianisch',
    'ch': 'Chamorro',
    'ce': 'Tschetschenisch',
    'ny': 'Chichewa',
    'zh': 'Chinesisch',
    'cv': 'Tschuwaschisch',
    'kw': 'Kornisch',
    'co': 'Korsisch',
    'cr': 'Cree',
    'hr': 'Kroatisch',
    'cs': 'Tschechisch',
    'da': 'Dänisch',
    'dv': 'Dhivehi',
    'nl': 'Néerlandais, Flamand',
    'dz': 'Dzongkha',
    'en': 'Englisch',
    'eo': 'Esperanto',
    'et': 'Estnisch',
    'ee': 'Ewe',
    'fo': 'Färöisch',
    'fj': 'Fidschi',
    'fi': 'Finnisch',
    'fr': 'Français',
    'ff': 'Fulfulde',
    'gl': 'Galicisch, Galegisch',
    'ka': 'Georgisch',
    'de': 'Deutsch',
    'el': 'Griechisch',
    'gn': 'Guaraní',
    'gu': 'Gujarati',
    'ht': 'Haitianisch',
    'ha': 'Hausa',
    'he': 'Hebräisch',
    'hz': 'Otjiherero',
    'hi': 'Hindi',
    'ho': 'Hiri Motu',
    'hu': 'Ungarisch',
    'ia': 'Interlingua',
    'id': 'Indonesisch',
    'ie': 'Interlingue',
    'ga': 'Irisch',
    'ig': 'Igbo',
    'ik': 'Inupiaq',
    'io': 'Ido',
    'is': 'Isländisch',
    'it': 'Italien',
    'iu': 'Inuktitut',
    'ja': 'Japanisch',
    'jv': 'Javanisch',
    'kl': 'Grönländisch, Kalaallisut',
    'kn': 'Kannada',
    'kr': 'Kanuri',
    'ks': 'Kashmiri',
    'kk': 'Kasachisch',
    'km': 'Khmer',
    'ki': 'Kikuyu',
    'rw': 'Kinyarwanda, Ruandisch',
    'ky': 'Kirgisisch',
    'kv': 'Komi',
    'kg': 'Kikongo',
    'ko': 'Koréen',
    'ku': 'Kurdisch',
    'kj': 'oshiKwanyama',
    'la': 'Latein',
    'lb': 'Luxemburgisch',
    'lg': 'Luganda',
    'li': 'Limburgisch, Südniederfränkisch',
    'ln': 'Lingála',
    'lo': 'Laotisch',
    'lt': 'Litauisch',
    'lu': 'Kiluba',
    'lv': 'Lettisch',
    'gv': 'Manx,Manx-Gälisch',
    'mk': 'Mazedonisch',
    'mg': 'Malagasy, Malagassi',
    'ms': 'Malaiisch',
    'ml': 'Malayalam',
    'mt': 'Maltesisch',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mh': 'Marshallesisch',
    'mn': 'Mongolisch',
    'na': 'Nauruisch',
    'nv': 'Navajo',
    'nd': 'Nord-Ndebele',
    'ne': 'Nepali',
    'ng': 'Ndonga',
    'nb': 'Bokmål',
    'nn': 'Nynorsk',
    'no': 'Norwegisch',
    'ii': 'Yi',
    'nr': 'Süd-Ndebele',
    'oc': 'Okzitanisch',
    'oj': 'Ojibwe',
    'cu': 'Kirchenslawisch, Altkirchenslawisch',
    'om': 'Oromo',
    'or': 'Oriya',
    'os': 'Ossetisch',
    'pa': 'Panjabi, Pandschabi',
    'pi': 'Pali',
    'fa': 'Persisch',
    'pl': 'Polnisch',
    'ps': 'Paschtunisch',
    'pt': 'Portugais',
    'qu': 'Quechua',
    'rm': 'Bündnerromanisch, Romanisch',
    'rn': 'Kirundi',
    'ro': 'Rumänisch',
    'ru': 'Russisch',
    'sa': 'Sanskrit',
    'sc': 'Sardisch',
    'sd': 'Sindhi',
    'se': 'Nordsamisch',
    'sm': 'Samoanisch',
    'sg': 'Sango',
    'sr': 'Serbisch',
    'gd': 'Schottisch-gälisch',
    'sn': 'Shona',
    'si': 'Singhalesisch',
    'sk': 'Slowakisch',
    'sl': 'Slowenisch',
    'so': 'Somali',
    'st': 'Sesotho, Süd-Sotho',
    'es': 'Espagnol, Catalan',
    'su': 'Sundanesisch',
    'sw': 'Swahili',
    'ss': 'Siswati',
    'sv': 'Schwedisch',
    'ta': 'Tamil',
    'te': 'Telugu',
    'tg': 'Tadschikisch',
    'th': 'Thai',
    'ti': 'Tigrinya',
    'bo': 'Tibetisch',
    'tk': 'Turkmenisch',
    'tl': 'Tagalog',
    'tn': 'Setswana',
    'to': 'Tongaisch',
    'tr': 'Türkisch',
    'ts': 'Xitsonga',
    'tt': 'Tatarisch',
    'tw': 'Twi',
    'ty': 'Tahitianisch, Tahitisch',
    'ug': 'Uigurisch',
    'uk': 'Ukrainisch',
    'ur': 'Urdu',
    'uz': 'Usbekisch',
    've': 'Tshivenda',
    'vi': 'Vietnamesisch',
    'vo': 'Volapük',
    'wa': 'Wallonisch',
    'cy': 'Walisisch',
    'wo': 'Wolof',
    'fy': 'Westfriesisch',
    'xh': 'isiXhosa',
    'yi': 'Jiddisch',
    'yo': 'Yoruba',
    'za': 'Zhuang',
    'zu': 'isiZulu',
  };
}
