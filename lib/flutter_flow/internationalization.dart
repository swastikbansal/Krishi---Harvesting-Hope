import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'hi', 'pa', 'mr', 'gu'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? hiText = '',
    String? paText = '',
    String? mrText = '',
    String? guText = '',
  }) =>
      [enText, hiText, paText, mrText, guText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // home1
  {
    'b7p1u1kn': {
      'en': 'Krishi',
      'gu': 'કૃષિ',
      'hi': 'कृषि',
      'mr': 'कृषी',
      'pa': 'ਕ੍ਰਿਸ਼ੀ',
    },
    'ttjrvqxe': {
      'en': 'Hey ',
      'gu': 'અરે',
      'hi': 'अरे',
      'mr': 'अरे',
      'pa': 'ਹੇ',
    },
    'b46kwpvj': {
      'en': '!',
      'gu': '!',
      'hi': '!',
      'mr': '!',
      'pa': '!',
    },
    'qavev3nq': {
      'en': 'Good Soil Health!',
      'gu': 'સારી માટીની તંદુરસ્તી!',
      'hi': 'मिट्टी का अच्छा स्वास्थ्य!',
      'mr': 'मातीचे आरोग्य चांगले!',
      'pa': 'ਮਿੱਟੀ ਦੀ ਚੰਗੀ ਸਿਹਤ!',
    },
    '59ace6qm': {
      'en': 'Last updated: 12:35 PM, 15 March 2025',
      'gu': 'છેલ્લે અપડેટ: 12:35 PM, 15 માર્ચ 2025',
      'hi': 'अंतिम अपडेट: 12:35 अपराह्न, 15 मार्च 2025',
      'mr': 'शेवटचे अपडेट: दुपारी १२:३५, १५ मार्च २०२५',
      'pa': 'ਆਖਰੀ ਵਾਰ ਅੱਪਡੇਟ ਕੀਤਾ ਗਿਆ: 12:35 PM, 15 ਮਾਰਚ 2025',
    },
    'v8kqkzr2': {
      'en': 'Today\'s Weather',
      'gu': 'આજનું હવામાન',
      'hi': 'आज का मौसम',
      'mr': 'आजचे हवामान',
      'pa': 'ਅੱਜ ਦਾ ਮੌਸਮ',
    },
    'n2c5b4lq': {
      'en': 'View',
      'gu': 'જુઓ',
      'hi': 'देखना',
      'mr': 'पहा',
      'pa': 'ਵੇਖੋ',
    },
    'ok5ty6lc': {
      'en': 'Humidity:',
      'gu': 'ભેજ:',
      'hi': 'नमी:',
      'mr': 'आर्द्रता:',
      'pa': 'ਨਮੀ:',
    },
    '9uv46we9': {
      'en': 'Humidity: 65%',
      'gu': 'ભેજ: ૬૫%',
      'hi': 'आर्द्रता: 65%',
      'mr': 'आर्द्रता: ६५%',
      'pa': 'ਨਮੀ: 65%',
    },
    '8g5fiw3o': {
      'en': 'City: ',
      'gu': 'શહેર:',
      'hi': 'शहर:',
      'mr': 'शहर:',
      'pa': 'ਸ਼ਹਿਰ:',
    },
    'gmpzstfk': {
      'en': 'Rainfall: 0 mm',
      'gu': 'વરસાદ: 0 મીમી',
      'hi': 'वर्षा: 0 मिमी',
      'mr': 'पाऊस: ० मिमी',
      'pa': 'ਮੀਂਹ: 0 ਮਿਲੀਮੀਟਰ',
    },
    '2hxyunr3': {
      'en': '6',
      'gu': '6',
      'hi': '6',
      'mr': '६',
      'pa': '6',
    },
    'obqqme5l': {
      'en': 'Today\'s Soil Scans',
      'gu': 'આજના માટી સ્કેન',
      'hi': 'आज की मृदा स्कैन',
      'mr': 'आजचे मातीचे परीक्षण',
      'pa': 'ਅੱਜ ਦੇ ਮਿੱਟੀ ਦੇ ਸਕੈਨ',
    },
    'qdlxpliu': {
      'en': '₹10,200 ',
      'gu': '₹૧૦,૨૦૦',
      'hi': '₹10,200',
      'mr': '₹१०,२००',
      'pa': '₹10,200',
    },
    '7j4q470t': {
      'en': 'Money Saved',
      'gu': 'પૈસા બચાવ્યા',
      'hi': 'पैसा बचाया',
      'mr': 'पैसे वाचवले',
      'pa': 'ਪੈਸੇ ਬਚਾਏ ਗਏ',
    },
    '5r9zj0hc': {
      'en': 'Sensor Data Readings',
      'gu': 'સેન્સર ડેટા રીડિંગ્સ',
      'hi': 'सेंसर डेटा रीडिंग',
      'mr': 'सेन्सर डेटा रीडिंग्ज',
      'pa': 'ਸੈਂਸਰ ਡਾਟਾ ਰੀਡਿੰਗ',
    },
    'qt0imsjy': {
      'en': 'Soil Moisture',
      'gu': 'માટીનો ભેજ',
      'hi': 'मिट्टी की नमी',
      'mr': 'मातीचा ओलावा',
      'pa': 'ਮਿੱਟੀ ਦੀ ਨਮੀ',
    },
    'zdkhl8wq': {
      'en': '6.5',
      'gu': '૬.૫',
      'hi': '6.5',
      'mr': '६.५',
      'pa': '6.5',
    },
    '6lywxetd': {
      'en': 'Soil pH',
      'gu': 'માટીનો pH',
      'hi': 'मिट्टी का पीएच',
      'mr': 'मातीचा सामू',
      'pa': 'ਮਿੱਟੀ ਦਾ pH',
    },
    'b2gckazf': {
      'en': 'N: 35 | P: 45 | K: 66',
      'gu': 'ન: ૩૫ | પાનું: ૪૫ | કે: ૬૬',
      'hi': 'संख्या: 35 | पी: 45 | के: 66',
      'mr': 'क्रमांक: ३५ | पृष्ठ: ४५ | के: ६६',
      'pa': 'ਨੰਬਰ: 35 | ਪੰਨਾ: 45 | ਕੇ: 66',
    },
    's3ixjf4j': {
      'en': 'NPK Value',
      'gu': 'NPK મૂલ્ય',
      'hi': 'एनपीके मूल्य',
      'mr': 'एनपीके मूल्य',
      'pa': 'NPK ਮੁੱਲ',
    },
    'yjay8kzp': {
      'en': 'Electrical Conductivity',
      'gu': 'વિદ્યુત વાહકતા',
      'hi': 'इलेक्ट्रिकल कंडक्टीविटी',
      'mr': 'विद्युत चालकता',
      'pa': 'ਬਿਜਲੀ ਚਾਲਕਤਾ',
    },
    'b7w1vuvi': {
      'en': 'Last updated: 12:35 PM, 15 March 2025',
      'gu': 'છેલ્લે અપડેટ: 12:35 PM, 15 માર્ચ 2025',
      'hi': 'अंतिम अपडेट: 12:35 अपराह्न, 15 मार्च 2025',
      'mr': 'शेवटचे अपडेट: दुपारी १२:३५, १५ मार्च २०२५',
      'pa': 'ਆਖਰੀ ਵਾਰ ਅੱਪਡੇਟ ਕੀਤਾ ਗਿਆ: 12:35 PM, 15 ਮਾਰਚ 2025',
    },
    'kema9xw7': {
      'en': 'Today\'s Weather',
      'gu': 'આજનું હવામાન',
      'hi': 'आज का मौसम',
      'mr': 'आजचे हवामान',
      'pa': 'ਅੱਜ ਦਾ ਮੌਸਮ',
    },
    '3t2lti7j': {
      'en': 'View',
      'gu': 'જુઓ',
      'hi': 'देखना',
      'mr': 'पहा',
      'pa': 'ਵੇਖੋ',
    },
    '3kqyz8c9': {
      'en': '28°C',
      'gu': '૨૮°સે',
      'hi': '28° सेल्सियस',
      'mr': '२८°C',
      'pa': '28°C',
    },
    'zmk6xsgr': {
      'en': 'Partly Cloudy',
      'gu': 'આંશિક વાદળછાયું',
      'hi': 'आंशिक रूप से बादल छाएंगे',
      'mr': 'अंशतः ढगाळ',
      'pa': 'ਥੋੜੇ ਜਿਹੇ ਬੱਦਲ',
    },
    'frqe1ar9': {
      'en': 'Humidity: 65%',
      'gu': 'ભેજ: ૬૫%',
      'hi': 'आर्द्रता: 65%',
      'mr': 'आर्द्रता: ६५%',
      'pa': 'ਨਮੀ: 65%',
    },
    'il4ts6ny': {
      'en': 'Wind: 12 km/h',
      'gu': 'પવન: ૧૨ કિમી/કલાક',
      'hi': 'हवा: 12 किमी/घंटा',
      'mr': 'वारा: १२ किमी/ताशी',
      'pa': 'ਹਵਾ: 12 ਕਿਲੋਮੀਟਰ ਪ੍ਰਤੀ ਘੰਟਾ',
    },
    'cmf0g380': {
      'en': 'Rainfall: 0 mm',
      'gu': 'વરસાદ: 0 મીમી',
      'hi': 'वर्षा: 0 मिमी',
      'mr': 'पाऊस: ० मिमी',
      'pa': 'ਮੀਂਹ: 0 ਮਿਲੀਮੀਟਰ',
    },
    'hloe02g1': {
      'en': 'Farming Updates',
      'gu': 'ખેતી સંબંધિત અપડેટ્સ',
      'hi': 'खेती संबंधी अपडेट',
      'mr': 'शेतीविषयक अपडेट्स',
      'pa': 'ਖੇਤੀ ਸੰਬੰਧੀ ਅੱਪਡੇਟ',
    },
    'o7eq9yj5': {
      'en': 'For more info tap the image to visit site.',
      'gu': 'વધુ માહિતી માટે, સાઇટની મુલાકાત લેવા માટે છબી પર ટેપ કરો.',
      'hi': 'अधिक जानकारी के लिए साइट पर जाने हेतु चित्र पर टैप करें।',
      'mr': 'अधिक माहितीसाठी साइटला भेट देण्यासाठी प्रतिमेवर टॅप करा.',
      'pa': 'ਹੋਰ ਜਾਣਕਾਰੀ ਲਈ ਸਾਈਟ \'ਤੇ ਜਾਣ ਲਈ ਚਿੱਤਰ \'ਤੇ ਟੈਪ ਕਰੋ।',
    },
    '6zxagodk': {
      'en': 'Connect and find Local Suppliers',
      'gu': 'નવી સરકારી યોજનાઓ',
      'hi': 'नई सरकारी योजनाएँ',
      'mr': 'नवीन सरकारी योजना',
      'pa': 'ਨਵੀਆਂ ਸਰਕਾਰੀ ਯੋਜਨਾਵਾਂ',
    },
    'ainbm5s0': {
      'en': 'Pest Management Guide',
      'gu': 'જંતુ વ્યવસ્થાપન માર્ગદર્શિકા',
      'hi': 'कीट प्रबंधन गाइड',
      'mr': 'कीटक व्यवस्थापन मार्गदर्शक',
      'pa': 'ਕੀਟ ਪ੍ਰਬੰਧਨ ਗਾਈਡ',
    },
    'zmhfwmlh': {
      'en': 'Organic Farming Guide',
      'gu': 'ઓર્ગેનિક ખેતી માર્ગદર્શિકા',
      'hi': 'जैविक खेती गाइड',
      'mr': 'सेंद्रिय शेती मार्गदर्शक',
      'pa': 'ਜੈਵਿਕ ਖੇਤੀ ਗਾਈਡ',
    },
    'u639daue': {
      'en': 'New Irrigation Techniques',
      'gu': 'નવી સિંચાઈ તકનીકો',
      'hi': 'नई सिंचाई तकनीकें',
      'mr': 'नवीन सिंचन तंत्रे',
      'pa': 'ਨਵੀਆਂ ਸਿੰਚਾਈ ਤਕਨੀਕਾਂ',
    },
    'pa1u7koe': {
      'en': 'New Government Schemes',
      'gu': 'નવી સરકારી યોજનાઓ',
      'hi': 'नई सरकारी योजनाएँ',
      'mr': 'नवीन सरकारी योजना',
      'pa': 'ਨਵੀਆਂ ਸਰਕਾਰੀ ਯੋਜਨਾਵਾਂ',
    },
    'gfqdr4xx': {
      'en': 'Enable Soil Alerts',
      'gu': 'માટી ચેતવણીઓ સક્ષમ કરો',
      'hi': 'मृदा अलर्ट सक्षम करें',
      'mr': 'माती सूचना सक्षम करा',
      'pa': 'ਮਿੱਟੀ ਚੇਤਾਵਨੀਆਂ ਨੂੰ ਸਮਰੱਥ ਬਣਾਓ',
    },
    'uqwwpmxz': {
      'en': 'Alert Timing Settings',
      'gu': 'ચેતવણી સમય સેટિંગ્સ',
      'hi': 'अलर्ट समय सेटिंग',
      'mr': 'अलर्ट वेळेची सेटिंग्ज',
      'pa': 'ਚੇਤਾਵਨੀ ਸਮਾਂ ਸੈਟਿੰਗਾਂ',
    },
    '3isqrm4z': {
      'en': 'Configure when and how often you receive alerts',
      'gu': 'તમને ક્યારે અને કેટલી વાર ચેતવણીઓ પ્રાપ્ત થાય છે તે ગોઠવો',
      'hi': 'कॉन्फ़िगर करें कि आपको अलर्ट कब और कितनी बार प्राप्त होंगे',
      'mr': 'तुम्हाला कधी आणि किती वेळा सूचना मिळतात ते कॉन्फिगर करा',
      'pa': 'ਤੁਹਾਨੂੰ ਕਦੋਂ ਅਤੇ ਕਿੰਨੀ ਵਾਰ ਅਲਰਟ ਪ੍ਰਾਪਤ ਹੁੰਦੇ ਹਨ, ਇਹ ਕੌਂਫਿਗਰ ਕਰੋ',
    },
    'z811o44i': {
      'en': 'Alert Time',
      'gu': 'ચેતવણી સમય',
      'hi': 'चेतावनी समय',
      'mr': 'सूचना वेळ',
      'pa': 'ਚੇਤਾਵਨੀ ਸਮਾਂ',
    },
    'y0ecwtwp': {
      'en': 'Set Alert Date and Time',
      'gu': 'ચેતવણી તારીખ અને સમય સેટ કરો',
      'hi': 'अलर्ट दिनांक और समय सेट करें',
      'mr': 'अलर्ट तारीख आणि वेळ सेट करा',
      'pa': 'ਚੇਤਾਵਨੀ ਮਿਤੀ ਅਤੇ ਸਮਾਂ ਸੈੱਟ ਕਰੋ',
    },
    'cnxxpnzo': {
      'en': 'Alert Frequency',
      'gu': 'ચેતવણી આવર્તન',
      'hi': 'चेतावनी आवृत्ति',
      'mr': 'अलर्ट वारंवारता',
      'pa': 'ਚੇਤਾਵਨੀ ਬਾਰੰਬਾਰਤਾ',
    },
    'u44ugzsn': {
      'en': 'Daily',
      'gu': 'દૈનિક',
      'hi': 'दैनिक',
      'mr': 'दैनंदिन',
      'pa': 'ਰੋਜ਼ਾਨਾ',
    },
    'u9qeni44': {
      'en': 'Daily',
      'gu': 'દૈનિક',
      'hi': 'दैनिक',
      'mr': 'दैनंदिन',
      'pa': 'ਰੋਜ਼ਾਨਾ',
    },
    'vzl0w5fb': {
      'en': 'Weekly',
      'gu': 'સાપ્તાહિક',
      'hi': 'साप्ताहिक',
      'mr': 'साप्ताहिक',
      'pa': 'ਹਫ਼ਤਾਵਾਰੀ',
    },
    '6cjy3lga': {
      'en': 'Monthly',
      'gu': 'માસિક',
      'hi': 'महीने के',
      'mr': 'मासिक',
      'pa': 'ਮਹੀਨੇਵਾਰ',
    },
    '3sjcqzec': {
      'en': 'Repeat Alerts',
      'gu': 'પુનરાવર્તિત ચેતવણીઓ',
      'hi': 'दोहराए गए अलर्ट',
      'mr': 'पुनरावृत्ती सूचना',
      'pa': 'ਦੁਹਰਾਓ ਚੇਤਾਵਨੀਆਂ',
    },
    'ac8hmyeb': {
      'en': 'Alert Interval',
      'gu': 'ચેતવણી અંતરાલ',
      'hi': 'चेतावनी अंतराल',
      'mr': 'सूचना मध्यांतर',
      'pa': 'ਚੇਤਾਵਨੀ ਅੰਤਰਾਲ',
    },
    '8pk7e12u': {
      'en': 'Time between repeated alerts',
      'gu': 'પુનરાવર્તિત ચેતવણીઓ વચ્ચેનો સમય',
      'hi': 'बार-बार अलर्ट के बीच का समय',
      'mr': 'पुनरावृत्ती होणाऱ्या सूचनांमधील वेळ',
      'pa': 'ਦੁਹਰਾਈਆਂ ਜਾਣ ਵਾਲੀਆਂ ਚੇਤਾਵਨੀਆਂ ਵਿਚਕਾਰ ਸਮਾਂ',
    },
    'rdjcoy2z': {
      'en': ' min',
      'gu': 'મિનિટ',
      'hi': 'मिन',
      'mr': 'किमान',
      'pa': 'ਮਿੰਟ',
    },
    '2ge2mly4': {
      'en': '30 min',
      'gu': '૩૦ મિનિટ',
      'hi': '30 मिनट',
      'mr': '३० मिनिटे',
      'pa': '30 ਮਿੰਟ',
    },
    'osq4futn': {
      'en': '5m',
      'gu': '૫ મી',
      'hi': '5 मिनट',
      'mr': '५ मी',
      'pa': '5 ਮੀ.',
    },
    'a8tz3l76': {
      'en': '60m',
      'gu': '૬૦ મી',
      'hi': '60 मीटर',
      'mr': '६० मी',
      'pa': '60 ਮੀ',
    },
    'mfm241pp': {
      'en': '120m',
      'gu': '૧૨૦ મી',
      'hi': '120मी',
      'mr': '१२० मी',
      'pa': '120 ਮੀ',
    },
    'x0ci59f0': {
      'en': 'Save Alert Settings',
      'gu': 'ચેતવણી સેટિંગ્સ સાચવો',
      'hi': 'अलर्ट सेटिंग सहेजें',
      'mr': 'अलर्ट सेटिंग्ज सेव्ह करा',
      'pa': 'ਚੇਤਾਵਨੀ ਸੈਟਿੰਗਾਂ ਨੂੰ ਸੁਰੱਖਿਅਤ ਕਰੋ',
    },
    'sollpo8v': {
      'en':
          'Made with ♡ love by IEEE SIGHT Group of AITR, Indore, Madhya Pradesh, India.',
      'gu':
          '♡ પ્રેમથી બનાવેલ, IEEE SIGHT ગ્રુપ ઓફ AITR, ઇન્દોર, મધ્યપ્રદેશ, ભારત દ્વારા.',
      'hi':
          'AITR, इंदौर, मध्य प्रदेश, भारत के IEEE SIGHT ग्रुप द्वारा ♡ प्यार से बनाया गया।',
      'mr':
          '♡ प्रेमाने बनवलेले, IEEE SIGHT ग्रुप ऑफ AITR, इंदूर, मध्य प्रदेश, भारत यांनी.',
      'pa':
          '♡ ਪਿਆਰ ਨਾਲ ਬਣਾਇਆ ਗਿਆ IEEE SIGHT ਗਰੁੱਪ ਆਫ਼ AITR, ਇੰਦੌਰ, ਮੱਧ ਪ੍ਰਦੇਸ਼, ਭਾਰਤ ਦੁਆਰਾ।',
    },
    'to8jikrx': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // ai2
  {
    'bglmktn8': {
      'en': 'Krishi AI',
      'gu': 'કૃષિ એઆઈ',
      'hi': 'कृषि एआई',
      'mr': 'कृषी एआय',
      'pa': 'ਕ੍ਰਿਸ਼ੀ ਏ.ਆਈ.',
    },
    '1r3ivi7t': {
      'en': 'Search',
      'gu': 'શોધો',
      'hi': 'खोज',
      'mr': 'शोध',
      'pa': 'ਖੋਜ',
    },
    '6vevojf5': {
      'en': 'Search',
      'gu': 'શોધો',
      'hi': 'खोज',
      'mr': 'शोध',
      'pa': 'ਖੋਜ',
    },
    'fpi1xe94': {
      'en': 'Ask Anything...',
      'gu': 'કંઈપણ પૂછો...',
      'hi': 'कुछ भी पूछें...',
      'mr': 'काहीही विचारा...',
      'pa': 'ਕੁਝ ਵੀ ਪੁੱਛੋ...',
    },
    'f94n9pmr': {
      'en': 'Tap to capture images, upload photos or files for AI analysis.',
      'gu':
          'AI વિશ્લેષણ માટે છબીઓ કેપ્ચર કરવા, ફોટા અથવા ફાઇલો અપલોડ કરવા માટે ટેપ કરો.',
      'hi':
          'AI विश्लेषण के लिए चित्र कैप्चर करने, फ़ोटो या फ़ाइलें अपलोड करने के लिए टैप करें.',
      'mr':
          'एआय विश्लेषणासाठी प्रतिमा कॅप्चर करण्यासाठी, फोटो किंवा फाइल्स अपलोड करण्यासाठी टॅप करा.',
      'pa':
          'AI ਵਿਸ਼ਲੇਸ਼ਣ ਲਈ ਤਸਵੀਰਾਂ ਕੈਪਚਰ ਕਰਨ, ਫੋਟੋਆਂ ਜਾਂ ਫਾਈਲਾਂ ਅੱਪਲੋਡ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ।',
    },
    'p8g3pv2v': {
      'en': 'Sensor Data',
      'gu': 'સેન્સર ડેટા',
      'hi': 'सेंसर डेटा',
      'mr': 'सेन्सर डेटा',
      'pa': 'ਸੈਂਸਰ ਡਾਟਾ',
    },
    'ajwo8bhj': {
      'en':
          'Toggle the button to fetch and upload real time sensor data for AI analysis.',
      'gu':
          'AI વિશ્લેષણ માટે રીઅલ ટાઇમ સેન્સર ડેટા મેળવવા અને અપલોડ કરવા માટે બટનને ટૉગલ કરો.',
      'hi':
          'AI विश्लेषण के लिए वास्तविक समय सेंसर डेटा प्राप्त करने और अपलोड करने के लिए बटन को टॉगल करें।',
      'mr':
          'एआय विश्लेषणासाठी रिअल टाइम सेन्सर डेटा आणण्यासाठी आणि अपलोड करण्यासाठी बटण टॉगल करा.',
      'pa':
          'AI ਵਿਸ਼ਲੇਸ਼ਣ ਲਈ ਰੀਅਲ ਟਾਈਮ ਸੈਂਸਰ ਡੇਟਾ ਪ੍ਰਾਪਤ ਕਰਨ ਅਤੇ ਅਪਲੋਡ ਕਰਨ ਲਈ ਬਟਨ ਨੂੰ ਟੌਗਲ ਕਰੋ।',
    },
    'qcrn2e9f': {
      'en': 'Search',
      'gu': 'શોધો',
      'hi': 'खोज',
      'mr': 'शोध',
      'pa': 'ਖੋਜ',
    },
    'xouxjgfa': {
      'en':
          'Toggle the button to access data from the internet to retrive up to date facts.',
      'gu':
          'ઇન્ટરનેટ પરથી ડેટા મેળવવા માટે બટનને ટૉગલ કરો અને અપડેટેડ તથ્યો મેળવો.',
      'hi':
          'नवीनतम तथ्य प्राप्त करने के लिए इंटरनेट से डेटा तक पहुंचने हेतु बटन को टॉगल करें।',
      'mr':
          'अद्ययावत तथ्ये पुनर्प्राप्त करण्यासाठी इंटरनेटवरून डेटा अॅक्सेस करण्यासाठी बटण टॉगल करा.',
      'pa':
          'ਨਵੀਨਤਮ ਤੱਥਾਂ ਨੂੰ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ ਇੰਟਰਨੈੱਟ ਤੋਂ ਡੇਟਾ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਲਈ ਬਟਨ ਨੂੰ ਟੌਗਲ ਕਰੋ।',
    },
    '8u364mm9': {
      'en': 'Tap to give a voice input.',
      'gu': 'વૉઇસ ઇનપુટ આપવા માટે ટેપ કરો.',
      'hi': 'ध्वनि इनपुट देने के लिए टैप करें.',
      'mr': 'व्हॉइस इनपुट देण्यासाठी टॅप करा.',
      'pa': 'ਵੌਇਸ ਇਨਪੁੱਟ ਦੇਣ ਲਈ ਟੈਪ ਕਰੋ।',
    },
    'lku3o8bw': {
      'en': 'Tap to generate an AI response.',
      'gu': 'AI પ્રતિભાવ જનરેટ કરવા માટે ટેપ કરો.',
      'hi': 'AI प्रतिक्रिया उत्पन्न करने के लिए टैप करें.',
      'mr': 'एआय प्रतिसाद जनरेट करण्यासाठी टॅप करा.',
      'pa': 'AI ਜਵਾਬ ਤਿਆਰ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ।',
    },
    'vebhlzsq': {
      'en': 'AI',
      'gu': 'કૃત્રિમ',
      'hi': 'ऐ',
      'mr': 'एआय',
      'pa': 'ਏ.ਆਈ.',
    },
  },
  // account4
  {
    'db6fj3ez': {
      'en': 'Account',
      'gu': 'ખાતું',
      'hi': 'खाता',
      'mr': 'खाते',
      'pa': 'ਖਾਤਾ',
    },
    'awu57x95': {
      'en': 'Edit Profile',
      'gu': 'પ્રોફાઇલ સંપાદિત કરો',
      'hi': 'प्रोफ़ाइल संपादित करें',
      'mr': 'प्रोफाइल संपादित करा',
      'pa': 'ਪ੍ਰੋਫਾਈਲ ਸੋਧੋ',
    },
    '4qj21cto': {
      'en': 'Switch to Dark Mode',
      'gu': 'ડાર્ક મોડ પર સ્વિચ કરો',
      'hi': 'डार्क मोड पर स्विच करें',
      'mr': 'गडद मोडवर स्विच करा',
      'pa': 'ਡਾਰਕ ਮੋਡ \'ਤੇ ਜਾਓ',
    },
    'hvexuwte': {
      'en': 'Switch to Light Mode',
      'gu': 'લાઇટ મોડ પર સ્વિચ કરો',
      'hi': 'लाइट मोड पर स्विच करें',
      'mr': 'लाईट मोडवर स्विच करा',
      'pa': 'ਲਾਈਟ ਮੋਡ \'ਤੇ ਜਾਓ',
    },
    'izrikfzs': {
      'en': 'Change Password',
      'gu': 'પાસવર્ડ બદલો',
      'hi': 'पासवर्ड बदलें',
      'mr': 'पासवर्ड बदला',
      'pa': 'ਪਾਸਵਰਡ ਬਦਲੋ',
    },
    '0k9g8mpd': {
      'en': 'Sensor settings & scan alerts',
      'gu': 'સેન્સર સેટિંગ્સ અને સ્કેન ચેતવણીઓ',
      'hi': 'सेंसर सेटिंग्स और स्कैन अलर्ट',
      'mr': 'सेन्सर सेटिंग्ज आणि स्कॅन अलर्ट',
      'pa': 'ਸੈਂਸਰ ਸੈਟਿੰਗਾਂ ਅਤੇ ਸਕੈਨ ਅਲਰਟ',
    },
    'gadtdb18': {
      'en': 'App settings',
      'gu': 'એપ્લિકેશન સેટિંગ્સ',
      'hi': 'ऐप सेटिंग',
      'mr': 'अ‍ॅप सेटिंग्ज',
      'pa': 'ਐਪ ਸੈਟਿੰਗਾਂ',
    },
    '1u7vmrq0': {
      'en': 'Data export & management',
      'gu': 'ડેટા નિકાસ અને સંચાલન',
      'hi': 'डेटा निर्यात और प्रबंधन',
      'mr': 'डेटा निर्यात आणि व्यवस्थापन',
      'pa': 'ਡਾਟਾ ਨਿਰਯਾਤ ਅਤੇ ਪ੍ਰਬੰਧਨ',
    },
    '1n378het': {
      'en': 'Tutorial',
      'gu': 'ટ્યુટોરીયલ',
      'hi': 'ट्यूटोरियल',
      'mr': 'ट्यूटोरियल',
      'pa': 'ਟਿਊਟੋਰਿਅਲ',
    },
    '2f4isu4w': {
      'en': 'Support & Feedback',
      'gu': 'સપોર્ટ અને પ્રતિસાદ',
      'hi': 'समर्थन और प्रतिक्रिया',
      'mr': 'समर्थन आणि अभिप्राय',
      'pa': 'ਸਹਾਇਤਾ ਅਤੇ ਫੀਡਬੈਕ',
    },
    '8gu8sz4w': {
      'en': 'Report a Bug',
      'gu': 'બગની જાણ કરો',
      'hi': 'एक बग रिपोर्ट करो',
      'mr': 'बग नोंदवा',
      'pa': 'ਬੱਗ ਦੀ ਰਿਪੋਰਟ ਕਰੋ',
    },
    '68xvzl6f': {
      'en': 'Feature Request',
      'gu': 'સુવિધા વિનંતી',
      'hi': 'सुविधा का अनुरोध',
      'mr': 'वैशिष्ट्य विनंती',
      'pa': 'ਵਿਸ਼ੇਸ਼ਤਾ ਬੇਨਤੀ',
    },
    'gn5eejaa': {
      'en': 'Log Out',
      'gu': 'લોગ આઉટ',
      'hi': 'लॉग आउट',
      'mr': 'बाहेर पडा',
      'pa': 'ਲਾਗ ਆਊਟ ਕਰੋ',
    },
    'a9z0g6qm': {
      'en': 'Account',
      'gu': 'ખાતું',
      'hi': 'खाता',
      'mr': 'खाते',
      'pa': 'ਖਾਤਾ',
    },
  },
  // forgetPassword
  {
    '5s7wid7v': {
      'en': 'Forgot Password?',
      'gu': 'પાસવર્ડ ભૂલી ગયા છો?',
      'hi': 'पासवर्ड भूल गए?',
      'mr': 'पासवर्ड विसरलात?',
      'pa': 'ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ?',
    },
    'liv49dtt': {
      'en': 'Don\'t worry, we\'ll help you reset it',
      'gu': 'ચિંતા કરશો નહીં, અમે તમને તેને રીસેટ કરવામાં મદદ કરીશું.',
      'hi': 'चिंता न करें, हम इसे रीसेट करने में आपकी मदद करेंगे',
      'mr': 'काळजी करू नका, आम्ही ते रीसेट करण्यात मदत करू.',
      'pa': 'ਚਿੰਤਾ ਨਾ ਕਰੋ, ਅਸੀਂ ਇਸਨੂੰ ਰੀਸੈਟ ਕਰਨ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰਾਂਗੇ।',
    },
    'qhp86xs9': {
      'en': 'Back',
      'gu': 'પાછળ',
      'hi': 'पीछे',
      'mr': 'मागे',
      'pa': 'ਪਿੱਛੇ',
    },
    'vs81wfnp': {
      'en':
          'Enter your email address and we\'ll send you instructions to reset your password.',
      'gu':
          'તમારું ઇમેઇલ સરનામું દાખલ કરો અને અમે તમને તમારો પાસવર્ડ રીસેટ કરવા માટે સૂચનાઓ મોકલીશું.',
      'hi':
          'अपना ईमेल पता दर्ज करें और हम आपको अपना पासवर्ड रीसेट करने के निर्देश भेजेंगे।',
      'mr':
          'तुमचा ईमेल पत्ता एंटर करा आणि आम्ही तुमचा पासवर्ड रीसेट करण्यासाठी तुम्हाला सूचना पाठवू.',
      'pa':
          'ਆਪਣਾ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ ਅਤੇ ਅਸੀਂ ਤੁਹਾਨੂੰ ਤੁਹਾਡਾ ਪਾਸਵਰਡ ਰੀਸੈਟ ਕਰਨ ਲਈ ਨਿਰਦੇਸ਼ ਭੇਜਾਂਗੇ।',
    },
    'dx8vrt1n': {
      'en': 'Your email address...',
      'gu': 'તમારું ઇમેઇલ સરનામું...',
      'hi': 'आपका ईमेल पता...',
      'mr': 'तुमचा ईमेल पत्ता...',
      'pa': 'ਤੁਹਾਡਾ ਈਮੇਲ ਪਤਾ...',
    },
    '2gx9s3ll': {
      'en': 'Enter your email...',
      'gu': 'તમારું ઇમેઇલ દાખલ કરો...',
      'hi': 'अपना ईमेल दर्ज करें...',
      'mr': 'तुमचा ईमेल एंटर करा...',
      'pa': 'ਆਪਣਾ ਈਮੇਲ ਦਰਜ ਕਰੋ...',
    },
    'ksq378rd': {
      'en': 'Send Link',
      'gu': 'લિંક મોકલો',
      'hi': 'लिंक भेजें',
      'mr': 'लिंक पाठवा',
      'pa': 'ਲਿੰਕ ਭੇਜੋ',
    },
    'n7ysdymm': {
      'en': 'Forgot Password',
      'gu': 'પાસવર્ડ ભૂલી ગયા છો',
      'hi': 'पासवर्ड भूल गए',
      'mr': 'पासवर्ड विसरलात',
      'pa': 'ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ',
    },
    'sqtcr8ar': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // onboardingPage
  {
    '48290it7': {
      'en': 'Welcome to Krishi 🌱',
      'gu': 'કૃષિમાં આપનું સ્વાગત છે 🌱',
      'hi': 'कृषि में आपका स्वागत है 🌱',
      'mr': 'कृषी मध्ये आपले स्वागत आहे 🌱',
      'pa': 'ਕ੍ਰਿਸ਼ੀ 🌱 ਵਿੱਚ ਤੁਹਾਡਾ ਸਵਾਗਤ ਹੈ',
    },
    'jttx61ap': {
      'en':
          'Nurturing Nature with Technology. Get real-time insights and recommendations to optimize your farm\'s performance. Krishi is designed to help you monitor, analyze, and improve soil health with ease.',
      'gu':
          'ટેકનોલોજી વડે પ્રકૃતિનું પોષણ કરો. તમારા ખેતરના પ્રદર્શનને શ્રેષ્ઠ બનાવવા માટે વાસ્તવિક સમયની આંતરદૃષ્ટિ અને ભલામણો મેળવો. કૃષિ તમને સરળતાથી જમીનના સ્વાસ્થ્યનું નિરીક્ષણ, વિશ્લેષણ અને સુધારણા કરવામાં મદદ કરવા માટે રચાયેલ છે.',
      'hi':
          'प्रौद्योगिकी के साथ प्रकृति का पोषण करें। अपने खेत के प्रदर्शन को अनुकूलित करने के लिए वास्तविक समय की जानकारी और सिफारिशें प्राप्त करें। कृषि आपको आसानी से मिट्टी के स्वास्थ्य की निगरानी, ​​विश्लेषण और सुधार करने में मदद करने के लिए डिज़ाइन किया गया है।',
      'mr':
          'तंत्रज्ञानाच्या साहाय्याने निसर्गाचे संगोपन करणे. तुमच्या शेतीची कार्यक्षमता सुधारण्यासाठी रिअल-टाइम अंतर्दृष्टी आणि शिफारसी मिळवा. कृषी हे तुम्हाला मातीचे आरोग्य सहजतेने निरीक्षण, विश्लेषण आणि सुधारण्यास मदत करण्यासाठी डिझाइन केलेले आहे.',
      'pa':
          'ਤਕਨਾਲੋਜੀ ਨਾਲ ਕੁਦਰਤ ਦਾ ਪਾਲਣ-ਪੋਸ਼ਣ ਕਰੋ। ਆਪਣੇ ਫਾਰਮ ਦੀ ਕਾਰਗੁਜ਼ਾਰੀ ਨੂੰ ਅਨੁਕੂਲ ਬਣਾਉਣ ਲਈ ਅਸਲ-ਸਮੇਂ ਦੀਆਂ ਸੂਝਾਂ ਅਤੇ ਸਿਫ਼ਾਰਸ਼ਾਂ ਪ੍ਰਾਪਤ ਕਰੋ। ਕ੍ਰਿਸ਼ੀ ਨੂੰ ਮਿੱਟੀ ਦੀ ਸਿਹਤ ਦੀ ਨਿਗਰਾਨੀ, ਵਿਸ਼ਲੇਸ਼ਣ ਅਤੇ ਸੁਧਾਰ ਕਰਨ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰਨ ਲਈ ਤਿਆਰ ਕੀਤਾ ਗਿਆ ਹੈ।',
    },
    '7ib5jddq': {
      'en': 'Skip',
      'gu': 'છોડી દો',
      'hi': 'छोडना',
      'mr': 'वगळा',
      'pa': 'ਛੱਡੋ',
    },
    'hutotlh3': {
      'en': 'Smart Soil Testing with IoT Sensors',
      'gu': 'IoT સેન્સર્સ સાથે સ્માર્ટ માટી પરીક્ષણ',
      'hi': 'IoT सेंसर के साथ स्मार्ट मृदा परीक्षण',
      'mr': 'आयओटी सेन्सर्ससह स्मार्ट माती परीक्षण',
      'pa': 'ਆਈਓਟੀ ਸੈਂਸਰਾਂ ਨਾਲ ਸਮਾਰਟ ਮਿੱਟੀ ਜਾਂਚ',
    },
    '0f6j20gr': {
      'en':
          'Accurate data, better decisions. Measures critical soil metrics like moisture, pH, and nutrient levels using digital sensors or manual entry. Stay on top of your soil\'s health with real-time data collection and instant feedback.',
      'gu':
          'સચોટ ડેટા, વધુ સારા નિર્ણયો. ડિજિટલ સેન્સર અથવા મેન્યુઅલ એન્ટ્રીનો ઉપયોગ કરીને ભેજ, pH અને પોષક સ્તર જેવા મહત્વપૂર્ણ માટી મેટ્રિક્સને માપે છે. રીઅલ-ટાઇમ ડેટા સંગ્રહ અને ત્વરિત પ્રતિસાદ સાથે તમારી માટીના સ્વાસ્થ્યની ટોચ પર રહો.',
      'hi':
          'सटीक डेटा, बेहतर निर्णय। डिजिटल सेंसर या मैन्युअल प्रविष्टि का उपयोग करके नमी, पीएच और पोषक तत्वों के स्तर जैसे महत्वपूर्ण मिट्टी के मीट्रिक को मापता है। वास्तविक समय के डेटा संग्रह और तत्काल प्रतिक्रिया के साथ अपनी मिट्टी के स्वास्थ्य पर नज़र रखें।',
      'mr':
          'अचूक डेटा, चांगले निर्णय. डिजिटल सेन्सर किंवा मॅन्युअल एंट्री वापरून ओलावा, पीएच आणि पोषक पातळी यासारख्या महत्त्वाच्या मातीच्या मेट्रिक्सचे मोजमाप करते. रिअल-टाइम डेटा संकलन आणि त्वरित अभिप्रायासह तुमच्या मातीच्या आरोग्याबद्दल अद्ययावत रहा.',
      'pa':
          'ਸਹੀ ਡਾਟਾ, ਬਿਹਤਰ ਫੈਸਲੇ। ਡਿਜੀਟਲ ਸੈਂਸਰਾਂ ਜਾਂ ਮੈਨੂਅਲ ਐਂਟਰੀ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਨਮੀ, pH, ਅਤੇ ਪੌਸ਼ਟਿਕ ਤੱਤਾਂ ਦੇ ਪੱਧਰਾਂ ਵਰਗੇ ਮਹੱਤਵਪੂਰਨ ਮਿੱਟੀ ਦੇ ਮਾਪਦੰਡਾਂ ਨੂੰ ਮਾਪਦਾ ਹੈ। ਰੀਅਲ-ਟਾਈਮ ਡਾਟਾ ਸੰਗ੍ਰਹਿ ਅਤੇ ਤੁਰੰਤ ਫੀਡਬੈਕ ਨਾਲ ਆਪਣੀ ਮਿੱਟੀ ਦੀ ਸਿਹਤ ਦੇ ਸਿਖਰ \'ਤੇ ਰਹੋ।',
    },
    'vfguja44': {
      'en': 'Skip',
      'gu': 'છોડી દો',
      'hi': 'छोडना',
      'mr': 'वगळा',
      'pa': 'ਛੱਡੋ',
    },
    '3gkeguos': {
      'en': 'AI-Powered Recommendations and Predictions',
      'gu': 'AI-સંચાલિત ભલામણો અને આગાહીઓ',
      'hi': 'AI-संचालित अनुशंसाएँ और भविष्यवाणियाँ',
      'mr': 'एआय-संचालित शिफारसी आणि भाकिते',
      'pa': 'ਏਆਈ-ਸੰਚਾਲਿਤ ਸਿਫ਼ਾਰਸ਼ਾਂ ਅਤੇ ਭਵਿੱਖਬਾਣੀਆਂ',
    },
    'kddbg3fu': {
      'en':
          'Tailored advice for sustainable farming.\nHarness the power of AI to get customized suggestions—from fertilizer selection to irrigation schedules. Stay ahead with healthier crops and higher yields.',
      'gu':
          'ટકાઉ ખેતી માટે અનુરૂપ સલાહ.\nખાતરની પસંદગીથી લઈને સિંચાઈના સમયપત્રક સુધી - કસ્ટમાઇઝ્ડ સૂચનો મેળવવા માટે AI ની શક્તિનો ઉપયોગ કરો. સ્વસ્થ પાક અને ઉચ્ચ ઉપજ સાથે આગળ વધો.',
      'hi':
          'टिकाऊ खेती के लिए खास सलाह। उर्वरक चयन से लेकर सिंचाई कार्यक्रम तक अनुकूलित सुझाव पाने के लिए AI की शक्ति का उपयोग करें। स्वस्थ फसलों और उच्च पैदावार के साथ आगे बढ़ें।',
      'mr':
          'शाश्वत शेतीसाठी अनुकूल सल्ला.\nखतांच्या निवडीपासून ते सिंचन वेळापत्रकापर्यंत - सानुकूलित सूचना मिळविण्यासाठी एआयच्या शक्तीचा वापर करा. निरोगी पिके आणि उच्च उत्पादनासह पुढे रहा.',
      'pa':
          'ਟਿਕਾਊ ਖੇਤੀ ਲਈ ਅਨੁਕੂਲਿਤ ਸਲਾਹ।\nਖਾਦ ਦੀ ਚੋਣ ਤੋਂ ਲੈ ਕੇ ਸਿੰਚਾਈ ਸਮਾਂ-ਸਾਰਣੀ ਤੱਕ - ਅਨੁਕੂਲਿਤ ਸੁਝਾਅ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ AI ਦੀ ਸ਼ਕਤੀ ਦੀ ਵਰਤੋਂ ਕਰੋ। ਸਿਹਤਮੰਦ ਫਸਲਾਂ ਅਤੇ ਵੱਧ ਉਪਜ ਨਾਲ ਅੱਗੇ ਵਧੋ।',
    },
    '9qb36rmk': {
      'en': 'Skip',
      'gu': 'છોડી દો',
      'hi': 'छोडना',
      'mr': 'वगळा',
      'pa': 'ਛੱਡੋ',
    },
    'v9vgjbox': {
      'en': 'Track Progress and Visualize Performance',
      'gu': 'પ્રગતિને ટ્રૅક કરો અને પ્રદર્શનની કલ્પના કરો',
      'hi': 'प्रगति पर नज़र रखें और प्रदर्शन की कल्पना करें',
      'mr': 'प्रगतीचा मागोवा घ्या आणि कामगिरीची कल्पना करा',
      'pa': 'ਪ੍ਰਗਤੀ ਨੂੰ ਟਰੈਕ ਕਰੋ ਅਤੇ ਪ੍ਰਦਰਸ਼ਨ ਦੀ ਕਲਪਨਾ ਕਰੋ',
    },
    '4iixvm23': {
      'en':
          'Insights that drive results. Analyze trends and monitor crop performance over time with easy-to-read graphs and reports. Plan ahead with predictive insights and ensure continuous improvements season after season.',
      'gu':
          'પરિણામોને આગળ ધપાવતી આંતરદૃષ્ટિ. વાંચવામાં સરળ ગ્રાફ અને અહેવાલો સાથે વલણોનું વિશ્લેષણ કરો અને સમય જતાં પાક પ્રદર્શનનું નિરીક્ષણ કરો. આગાહીત્મક આંતરદૃષ્ટિ સાથે આગળની યોજના બનાવો અને દર સીઝનમાં સતત સુધારાઓ સુનિશ્ચિત કરો.',
      'hi':
          'परिणाम देने वाली अंतर्दृष्टि। आसानी से पढ़े जाने वाले ग्राफ़ और रिपोर्ट के साथ समय के साथ रुझानों का विश्लेषण करें और फसल के प्रदर्शन की निगरानी करें। पूर्वानुमानित अंतर्दृष्टि के साथ आगे की योजना बनाएं और हर मौसम में निरंतर सुधार सुनिश्चित करें।',
      'mr':
          'निकालांना चालना देणारी अंतर्दृष्टी. सहज वाचता येतील अशा आलेख आणि अहवालांसह ट्रेंडचे विश्लेषण करा आणि कालांतराने पीक कामगिरीचे निरीक्षण करा. भाकित करण्याच्या अंतर्दृष्टींसह आगाऊ योजना करा आणि हंगामानंतर सतत सुधारणा सुनिश्चित करा.',
      'pa':
          'ਨਤੀਜਿਆਂ ਨੂੰ ਅੱਗੇ ਵਧਾਉਣ ਵਾਲੀਆਂ ਸੂਝਾਂ। ਆਸਾਨੀ ਨਾਲ ਪੜ੍ਹਨ ਵਾਲੇ ਗ੍ਰਾਫਾਂ ਅਤੇ ਰਿਪੋਰਟਾਂ ਨਾਲ ਸਮੇਂ ਦੇ ਨਾਲ ਰੁਝਾਨਾਂ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ ਅਤੇ ਫਸਲ ਪ੍ਰਦਰਸ਼ਨ ਦੀ ਨਿਗਰਾਨੀ ਕਰੋ। ਭਵਿੱਖਬਾਣੀ ਸੂਝਾਂ ਨਾਲ ਅੱਗੇ ਦੀ ਯੋਜਨਾ ਬਣਾਓ ਅਤੇ ਸੀਜ਼ਨ ਦਰ ਸੀਜ਼ਨ ਨਿਰੰਤਰ ਸੁਧਾਰ ਯਕੀਨੀ ਬਣਾਓ।',
    },
    's9npb2pw': {
      'en': 'Get Started',
      'gu': 'શરૂ કરો',
      'hi': 'शुरू हो जाओ',
      'mr': 'सुरुवात करा',
      'pa': 'ਸ਼ੁਰੂ ਕਰੋ',
    },
    'upg2f2za': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // authPage
  {
    'y5vmdmsf': {
      'en': 'Krishi',
      'gu': 'કૃષિ',
      'hi': 'कृषि',
      'mr': 'कृषी',
      'pa': 'ਕ੍ਰਿਸ਼ੀ',
    },
    'fuhua9l4': {
      'en': 'Sign In',
      'gu': 'સાઇન ઇન કરો',
      'hi': 'दाखिल करना',
      'mr': 'साइन इन करा',
      'pa': 'ਸਾਈਨ - ਇਨ',
    },
    'wlbxa1lh': {
      'en': 'Email',
      'gu': 'ઇમેઇલ',
      'hi': 'ईमेल',
      'mr': 'ईमेल',
      'pa': 'ਈਮੇਲ',
    },
    '5w7su2dk': {
      'en': 'Enter your Email',
      'gu': 'તમારું ઇમેઇલ દાખલ કરો',
      'hi': 'अपना ईमेल दर्ज करें',
      'mr': 'तुमचा ईमेल एंटर करा',
      'pa': 'ਆਪਣਾ ਈਮੇਲ ਦਰਜ ਕਰੋ',
    },
    'zjz6abe0': {
      'en': 'Password',
      'gu': 'પાસવર્ડ',
      'hi': 'पासवर्ड',
      'mr': 'पासवर्ड',
      'pa': 'ਪਾਸਵਰਡ',
    },
    'sh7s3v0i': {
      'en': 'Enter password',
      'gu': 'પાસવર્ડ દાખલ કરો',
      'hi': 'पास वर्ड दर्ज करें',
      'mr': 'पासवर्ड एंटर करा',
      'pa': 'ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ',
    },
    '5ge5rbi7': {
      'en': 'Forgot Password ?',
      'gu': 'પાસવર્ડ ભૂલી ગયા છો?',
      'hi': 'पासवर्ड भूल गए ?',
      'mr': 'पासवर्ड विसरलात?',
      'pa': 'ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ ?',
    },
    'kr62xfgz': {
      'en': 'Sign In',
      'gu': 'સાઇન ઇન કરો',
      'hi': 'दाखिल करना',
      'mr': 'साइन इन करा',
      'pa': 'ਸਾਈਨ - ਇਨ',
    },
    'vjufifjs': {
      'en': 'Continue with Google',
      'gu': 'ગૂગલ સાથે ચાલુ રાખો',
      'hi': 'Google के साथ जारी रखें',
      'mr': 'Google सह सुरू ठेवा',
      'pa': 'ਗੂਗਲ ਨਾਲ ਜਾਰੀ ਰੱਖੋ',
    },
    'pk0u8tts': {
      'en': 'Sign Up',
      'gu': 'સાઇન અપ કરો',
      'hi': 'साइन अप करें',
      'mr': 'साइन अप करा',
      'pa': 'ਸਾਇਨ ਅਪ',
    },
    'dx6ru54a': {
      'en': 'Name',
      'gu': 'નામ',
      'hi': 'नाम',
      'mr': 'नाव',
      'pa': 'ਨਾਮ',
    },
    'mbqh90w1': {
      'en': 'Enter your Name',
      'gu': 'તમારું નામ દાખલ કરો',
      'hi': 'अपना नाम दर्ज करें',
      'mr': 'तुमचे नाव एंटर करा',
      'pa': 'ਆਪਣਾ ਨਾਮ ਦਰਜ ਕਰੋ',
    },
    'nm4hrg8g': {
      'en': 'Email',
      'gu': 'ઇમેઇલ',
      'hi': 'ईमेल',
      'mr': 'ईमेल',
      'pa': 'ਈਮੇਲ',
    },
    'oi3zqmiw': {
      'en': 'Enter your Email',
      'gu': 'તમારું ઇમેઇલ દાખલ કરો',
      'hi': 'अपना ईमेल दर्ज करें',
      'mr': 'तुमचा ईमेल एंटर करा',
      'pa': 'ਆਪਣਾ ਈਮੇਲ ਦਰਜ ਕਰੋ',
    },
    'a2778e91': {
      'en': 'Password',
      'gu': 'પાસવર્ડ',
      'hi': 'पासवर्ड',
      'mr': 'पासवर्ड',
      'pa': 'ਪਾਸਵਰਡ',
    },
    't7stvl42': {
      'en': 'Enter password',
      'gu': 'પાસવર્ડ દાખલ કરો',
      'hi': 'पास वर्ड दर्ज करें',
      'mr': 'पासवर्ड एंटर करा',
      'pa': 'ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ',
    },
    'dy43jekg': {
      'en': 'Confirm Password',
      'gu': 'પાસવર્ડ કન્ફર્મ કરો',
      'hi': 'पासवर्ड की पुष्टि कीजिये',
      'mr': 'पासवर्डची पुष्टी करा',
      'pa': 'ਪਾਸਵਰਡ ਪੱਕਾ ਕਰੋ',
    },
    'mm8bwvjd': {
      'en': 'Confirm Password',
      'gu': 'પાસવર્ડ કન્ફર્મ કરો',
      'hi': 'पासवर्ड की पुष्टि कीजिये',
      'mr': 'पासवर्डची पुष्टी करा',
      'pa': 'ਪਾਸਵਰਡ ਪੱਕਾ ਕਰੋ',
    },
    'l3k0hk6a': {
      'en': 'Create Account',
      'gu': 'ખાતું બનાવો',
      'hi': 'खाता बनाएं',
      'mr': 'खाते तयार करा',
      'pa': 'ਖਾਤਾ ਬਣਾਉ',
    },
    '42vr4n4d': {
      'en': 'Continue with Google',
      'gu': 'ગૂગલ સાથે ચાલુ રાખો',
      'hi': 'Google के साथ जारी रखें',
      'mr': 'Google सह सुरू ठेवा',
      'pa': 'ਗੂਗਲ ਨਾਲ ਜਾਰੀ ਰੱਖੋ',
    },
    'ofxd9xxs': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // appSettings
  {
    'crinbva9': {
      'en': 'Push Notifications',
      'gu': 'પુશ સૂચનાઓ',
      'hi': 'सूचनाएं धक्का',
      'mr': 'पुश सूचना',
      'pa': 'ਪੁਸ਼ ਸੂਚਨਾਵਾਂ',
    },
    '1w66yoyg': {
      'en': 'Receive updates and alerts',
      'gu': 'અપડેટ્સ અને ચેતવણીઓ પ્રાપ્ત કરો',
      'hi': 'अपडेट और अलर्ट प्राप्त करें',
      'mr': 'अपडेट्स आणि सूचना मिळवा',
      'pa': 'ਅੱਪਡੇਟ ਅਤੇ ਚੇਤਾਵਨੀਆਂ ਪ੍ਰਾਪਤ ਕਰੋ',
    },
    'bxf1v0f8': {
      'en': 'Auto-Update',
      'gu': 'સ્વતઃ-અપડેટ',
      'hi': 'ऑटो अपडेट',
      'mr': 'ऑटो-अपडेट',
      'pa': 'ਆਟੋ-ਅੱਪਡੇਟ',
    },
    'k68zqv6c': {
      'en': 'Keep app up to date automatically',
      'gu': 'એપ્લિકેશનને આપમેળે અપ ટુ ડેટ રાખો',
      'hi': 'ऐप को स्वचालित रूप से अपडेट रखें',
      'mr': 'अ‍ॅप स्वयंचलितपणे अद्ययावत ठेवा',
      'pa': 'ਐਪ ਨੂੰ ਆਪਣੇ ਆਪ ਅੱਪ ਟੂ ਡੇਟ ਰੱਖੋ',
    },
    'oj544led': {
      'en': 'Usage Data',
      'gu': 'વપરાશ ડેટા',
      'hi': 'डेटा का उपयोग',
      'mr': 'वापर डेटा',
      'pa': 'ਵਰਤੋਂ ਡੇਟਾ',
    },
    'a4mvmumj': {
      'en': 'Help improve app experience',
      'gu': 'એપ્લિકેશન અનુભવને બહેતર બનાવવામાં સહાય કરો',
      'hi': 'ऐप अनुभव को बेहतर बनाने में सहायता करें',
      'mr': 'अ‍ॅप अनुभव सुधारण्यास मदत करा',
      'pa': 'ਐਪ ਅਨੁਭਵ ਨੂੰ ਬਿਹਤਰ ਬਣਾਉਣ ਵਿੱਚ ਮਦਦ ਕਰੋ',
    },
    'de49thpo': {
      'en': 'Select App Language',
      'gu': 'એપ્લિકેશન ભાષા પસંદ કરો',
      'hi': 'ऐप भाषा चुनें',
      'mr': 'अ‍ॅप भाषा निवडा',
      'pa': 'ਐਪ ਭਾਸ਼ਾ ਚੁਣੋ',
    },
    '2m9672zw': {
      'en': 'Clear Cache',
      'gu': 'કેશ સાફ કરો',
      'hi': 'कैश को साफ़ करें',
      'mr': 'कॅशे साफ करा',
      'pa': 'ਕੈਸ਼ ਸਾਫ਼ ਕਰੋ',
    },
    'cawvbzur': {
      'en': 'Privacy Policy',
      'gu': 'ગોપનીયતા નીતિ',
      'hi': 'गोपनीयता नीति',
      'mr': 'गोपनीयता धोरण',
      'pa': 'ਪਰਾਈਵੇਟ ਨੀਤੀ',
    },
    '47vjipsg': {
      'en': 'Terms of Service',
      'gu': 'સેવાની શરતો',
      'hi': 'सेवा की शर्तें',
      'mr': 'सेवा अटी',
      'pa': 'ਸੇਵਾ ਦੀਆਂ ਸ਼ਰਤਾਂ',
    },
    'go0t2s4l': {
      'en': 'Version',
      'gu': 'આવૃત્તિ',
      'hi': 'संस्करण',
      'mr': 'आवृत्ती',
      'pa': 'ਵਰਜਨ',
    },
    'ek4tmfpt': {
      'en': '2.1.0',
      'gu': '૨.૧.૦',
      'hi': '2.1.0',
      'mr': '२.१.०',
      'pa': '2.1.0',
    },
    'nx48zqs0': {
      'en': 'Developer',
      'gu': 'ડેવલપર',
      'hi': 'डेवलपर',
      'mr': 'विकसक',
      'pa': 'ਡਿਵੇਲਪਰ',
    },
    'p0gd70l0': {
      'en': 'IEEE SIGHT Group of AITR',
      'gu': 'AITR નું IEEE SIGHT ગ્રુપ',
      'hi': 'IEEE SIGHT AITR का समूह',
      'mr': 'आयईईई साईट ग्रुप ऑफ एआयटीआर',
      'pa': 'AITR ਦਾ IEEE SIGHT ਗਰੁੱਪ',
    },
    '6ux312vz': {
      'en': 'prabhjotassi16@gmail.com',
      'gu': 'prabhjotassi16@gmail.com',
      'hi': 'prabhjotassi16@gmail.com',
      'mr': 'prabhjotassi16@gmail.com वर ईमेल करा.',
      'pa': 'prabhjotassi16@gmail.com',
    },
    'cumkmioh': {
      'en': 'App Settings',
      'gu': 'એપ્લિકેશન સેટિંગ્સ',
      'hi': 'ऐप सेटिंग',
      'mr': 'अ‍ॅप सेटिंग्ज',
      'pa': 'ਐਪ ਸੈਟਿੰਗਾਂ',
    },
    'pa1rznxy': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // profilePage
  {
    'w6p09eo5': {
      'en': 'Full Name',
      'gu': 'પૂરું નામ',
      'hi': 'पूरा नाम',
      'mr': 'पूर्ण नाव',
      'pa': 'ਪੂਰਾ ਨਾਂਮ',
    },
    'vx1pkhg0': {
      'en': 'Enter your full name',
      'gu': 'તમારું પૂરું નામ દાખલ કરો',
      'hi': 'अपना पूरा नाम भरें',
      'mr': 'तुमचे पूर्ण नाव एंटर करा.',
      'pa': 'ਆਪਣਾ ਪੂਰਾ ਨਾਮ ਦਰਜ ਕਰੋ',
    },
    'ry5ldxg0': {
      'en': 'Username',
      'gu': 'વપરાશકર્તા નામ',
      'hi': 'उपयोगकर्ता नाम',
      'mr': 'वापरकर्तानाव',
      'pa': 'ਯੂਜ਼ਰਨੇਮ',
    },
    'om22bffs': {
      'en': 'Enter your username',
      'gu': 'તમારું વપરાશકર્તા નામ દાખલ કરો',
      'hi': 'अपना उपयोगकर्ता नाम दर्ज करें',
      'mr': 'तुमचे वापरकर्तानाव एंटर करा',
      'pa': 'ਆਪਣਾ ਯੂਜ਼ਰਨੇਮ ਦਰਜ ਕਰੋ',
    },
    '8444xflf': {
      'en': 'Email',
      'gu': 'ઇમેઇલ',
      'hi': 'ईमेल',
      'mr': 'ईमेल',
      'pa': 'ਈਮੇਲ',
    },
    '4tzdneqp': {
      'en': 'Enter your email',
      'gu': 'તમારું ઇમેઇલ દાખલ કરો',
      'hi': 'अपना ईमेल दर्ज करें',
      'mr': 'तुमचा ईमेल एंटर करा',
      'pa': 'ਆਪਣਾ ਈਮੇਲ ਦਰਜ ਕਰੋ',
    },
    'r6nscse6': {
      'en': 'Phone Number',
      'gu': 'ફોન નંબર',
      'hi': 'फ़ोन नंबर',
      'mr': 'फोन नंबर',
      'pa': 'ਫੋਨ ਨੰਬਰ',
    },
    'r8prz2lv': {
      'en': 'Enter your phone number',
      'gu': 'તમારો ફોન નંબર દાખલ કરો',
      'hi': 'अपना फोन नंबर डालें',
      'mr': 'तुमचा फोन नंबर एंटर करा',
      'pa': 'ਆਪਣਾ ਫ਼ੋਨ ਨੰਬਰ ਦਰਜ ਕਰੋ',
    },
    'zspc3ghz': {
      'en': 'State',
      'gu': 'રાજ્ય',
      'hi': 'राज्य',
      'mr': 'राज्य',
      'pa': 'ਰਾਜ',
    },
    '1hogzud4': {
      'en': 'Enter your State',
      'gu': 'તમારું રાજ્ય દાખલ કરો',
      'hi': 'अपना राज्य दर्ज करें',
      'mr': 'तुमचे राज्य एंटर करा',
      'pa': 'ਆਪਣਾ ਰਾਜ ਦਰਜ ਕਰੋ',
    },
    '8lbe4fa0': {
      'en': 'City',
      'gu': 'શહેર',
      'hi': 'शहर',
      'mr': 'शहर',
      'pa': 'ਸ਼ਹਿਰ',
    },
    'qjxm77o1': {
      'en': 'Enter your City',
      'gu': 'તમારું શહેર દાખલ કરો',
      'hi': 'अपना शहर दर्ज करें',
      'mr': 'तुमचे शहर प्रविष्ट करा',
      'pa': 'ਆਪਣਾ ਸ਼ਹਿਰ ਦਰਜ ਕਰੋ',
    },
    'pj4hm4ja': {
      'en': 'Bio',
      'gu': 'બાયો',
      'hi': 'जैव',
      'mr': 'बायो',
      'pa': 'ਬਾਇਓ',
    },
    'bhuxia72': {
      'en': 'Tell us about yourself',
      'gu': 'તમારા વિશે કહો.',
      'hi': 'अपने बारे में हमें बताएं',
      'mr': 'तुमच्याबद्दल सांगा.',
      'pa': 'ਸਾਨੂੰ ਆਪਣੇ ਬਾਰੇ ਦੱਸੋ।',
    },
    '61mvlx55': {
      'en': 'Save',
      'gu': 'સાચવો',
      'hi': 'बचाना',
      'mr': 'जतन करा',
      'pa': 'ਸੇਵ ਕਰੋ',
    },
    '5nm8mqyz': {
      'en': 'Profile',
      'gu': 'પ્રોફાઇલ',
      'hi': 'प्रोफ़ाइल',
      'mr': 'प्रोफाइल',
      'pa': 'ਪ੍ਰੋਫਾਈਲ',
    },
    'jfly2hd3': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // reportBug
  {
    'yrf4lusx': {
      'en': 'Welcome ',
      'gu': 'સ્વાગત છે',
      'hi': 'स्वागत',
      'mr': 'स्वागत आहे',
      'pa': 'ਸਵਾਗਤ ਹੈ',
    },
    'o2x362nb': {
      'en': '!',
      'gu': '!',
      'hi': '!',
      'mr': '!',
      'pa': '!',
    },
    '1byau343': {
      'en': 'Help us improve by reporting any issues you encounter.',
      'gu': 'તમને આવતી કોઈપણ સમસ્યાઓની જાણ કરીને અમને સુધારવામાં મદદ કરો.',
      'hi':
          'आपके सामने आने वाली किसी भी समस्या की रिपोर्ट करके हमें बेहतर बनाने में सहायता करें।',
      'mr':
          'तुम्हाला येणाऱ्या कोणत्याही समस्यांची तक्रार करून आम्हाला सुधारणा करण्यास मदत करा.',
      'pa':
          'ਤੁਹਾਨੂੰ ਆਉਣ ਵਾਲੀਆਂ ਕਿਸੇ ਵੀ ਸਮੱਸਿਆਵਾਂ ਦੀ ਰਿਪੋਰਟ ਕਰਕੇ ਸਾਨੂੰ ਬਿਹਤਰ ਬਣਾਉਣ ਵਿੱਚ ਮਦਦ ਕਰੋ।',
    },
    'scimictr': {
      'en': 'Bug Title',
      'gu': 'બગ શીર્ષક',
      'hi': 'बग शीर्षक',
      'mr': 'बग शीर्षक',
      'pa': 'ਬੱਗ ਸਿਰਲੇਖ',
    },
    '4wm1i1n2': {
      'en': 'Enter a brief description',
      'gu': 'ટૂંકું વર્ણન દાખલ કરો',
      'hi': 'संक्षिप्त विवरण दर्ज करें',
      'mr': 'थोडक्यात वर्णन एंटर करा',
      'pa': 'ਇੱਕ ਸੰਖੇਪ ਵਰਣਨ ਦਰਜ ਕਰੋ',
    },
    'vw57l11d': {
      'en': 'Description',
      'gu': 'વર્ણન',
      'hi': 'विवरण',
      'mr': 'वर्णन',
      'pa': 'ਵੇਰਵਾ',
    },
    'imqfhrd2': {
      'en': 'Please describe the issue in detail',
      'gu': 'કૃપા કરીને સમસ્યાનું વિગતવાર વર્ણન કરો.',
      'hi': 'कृपया समस्या का विस्तार से वर्णन करें',
      'mr': 'कृपया समस्येचे तपशीलवार वर्णन करा.',
      'pa': 'ਕਿਰਪਾ ਕਰਕੇ ਮੁੱਦੇ ਦਾ ਵਿਸਥਾਰ ਵਿੱਚ ਵਰਣਨ ਕਰੋ।',
    },
    '3e5169kl': {
      'en': 'Select Bug Type',
      'gu': 'બગ પ્રકાર પસંદ કરો',
      'hi': 'बग प्रकार चुनें',
      'mr': 'बग प्रकार निवडा',
      'pa': 'ਬੱਗ ਕਿਸਮ ਚੁਣੋ',
    },
    'jdki2jrn': {
      'en': 'UI Issue',
      'gu': 'UI સમસ્યા',
      'hi': 'यूआई समस्या',
      'mr': 'UI समस्या',
      'pa': 'UI ਸਮੱਸਿਆ',
    },
    'poeats1e': {
      'en': 'Performance Issue',
      'gu': 'પ્રદર્શન સમસ્યા',
      'hi': 'प्रदर्शन समस्या',
      'mr': 'कामगिरी समस्या',
      'pa': 'ਪ੍ਰਦਰਸ਼ਨ ਸਮੱਸਿਆ',
    },
    '76zaiaz8': {
      'en': 'Animation Issue',
      'gu': 'એનિમેશન સમસ્યા',
      'hi': 'एनीमेशन समस्या',
      'mr': 'अ‍ॅनिमेशन समस्या',
      'pa': 'ਐਨੀਮੇਸ਼ਨ ਮੁੱਦਾ',
    },
    'w4pxhfih': {
      'en': 'Translation Error',
      'gu': 'અનુવાદ ભૂલ',
      'hi': 'अनुवाद त्रुटि',
      'mr': 'भाषांतर त्रुटी',
      'pa': 'ਅਨੁਵਾਦ ਗਲਤੀ',
    },
    'fnadsd01': {
      'en': 'Camera Error',
      'gu': 'કેમેરા ભૂલ',
      'hi': 'कैमरा त्रुटि',
      'mr': 'कॅमेरा त्रुटी',
      'pa': 'ਕੈਮਰਾ ਗਲਤੀ',
    },
    'bnfnwro9': {
      'en': 'Other',
      'gu': 'અન્ય',
      'hi': 'अन्य',
      'mr': 'इतर',
      'pa': 'ਹੋਰ',
    },
    '5lmih9sc': {
      'en': 'Add Screenshot (Optional)',
      'gu': 'સ્ક્રીનશોટ ઉમેરો (વૈકલ્પિક)',
      'hi': 'स्क्रीनशॉट जोड़ें (वैकल्पिक)',
      'mr': 'स्क्रीनशॉट जोडा (पर्यायी)',
      'pa': 'ਸਕ੍ਰੀਨਸ਼ਾਟ ਸ਼ਾਮਲ ਕਰੋ (ਵਿਕਲਪਿਕ)',
    },
    '1i4obn1m': {
      'en': 'Tap to upload',
      'gu': 'અપલોડ કરવા માટે ટૅપ કરો',
      'hi': 'अपलोड करने के लिए टैप करें',
      'mr': 'अपलोड करण्यासाठी टॅप करा',
      'pa': 'ਅੱਪਲੋਡ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ',
    },
    '1q0eh5l5': {
      'en': 'Steps to Reproduce',
      'gu': 'પ્રજનન માટેનાં પગલાં',
      'hi': 'प्रजनन के चरण',
      'mr': 'पुनरुत्पादन करण्यासाठी पायऱ्या',
      'pa': 'ਦੁਬਾਰਾ ਪੈਦਾ ਕਰਨ ਲਈ ਕਦਮ',
    },
    'rfxcr2t2': {
      'en': 'List the steps to recreate this issue',
      'gu': 'આ સમસ્યાને ફરીથી બનાવવા માટેના પગલાંઓની યાદી બનાવો.',
      'hi': 'इस समस्या को पुनः बनाने के लिए चरणों की सूची बनाएं',
      'mr': 'ही समस्या पुन्हा निर्माण करण्यासाठी पायऱ्यांची यादी करा.',
      'pa': 'ਇਸ ਮੁੱਦੇ ਨੂੰ ਦੁਬਾਰਾ ਬਣਾਉਣ ਲਈ ਕਦਮਾਂ ਦੀ ਸੂਚੀ ਬਣਾਓ।',
    },
    'jtly93r2': {
      'en': 'Device Info',
      'gu': 'ઉપકરણ માહિતી',
      'hi': 'डिवाइस जानकारी',
      'mr': 'डिव्हाइस माहिती',
      'pa': 'ਡਿਵਾਈਸ ਜਾਣਕਾਰੀ',
    },
    'v8ibi18t': {
      'en': 'e.g. iPhone 13, Android 12 Phone',
      'gu': 'દા.ત. iPhone 13, Android 12 ફોન',
      'hi': 'जैसे iPhone 13, Android 12 फ़ोन',
      'mr': 'उदा. आयफोन १३, अँड्रॉइड १२ फोन',
      'pa': 'ਜਿਵੇਂ ਕਿ ਆਈਫੋਨ 13, ਐਂਡਰਾਇਡ 12 ਫੋਨ',
    },
    't27qax1s': {
      'en': 'Submit Report',
      'gu': 'રિપોર્ટ સબમિટ કરો',
      'hi': 'रिपोर्ट सबमिट करें',
      'mr': 'अहवाल सबमिट करा',
      'pa': 'ਰਿਪੋਰਟ ਜਮ੍ਹਾਂ ਕਰੋ',
    },
    'xuwz0vhz': {
      'en':
          'Our team will review your report and work on resolving the issue. Thank you for helping us improve!',
      'gu':
          'અમારી ટીમ તમારા રિપોર્ટની સમીક્ષા કરશે અને સમસ્યાનું નિરાકરણ લાવવા માટે કામ કરશે. અમને સુધારવામાં મદદ કરવા બદલ આભાર!',
      'hi':
          'हमारी टीम आपकी रिपोर्ट की समीक्षा करेगी और समस्या का समाधान करने पर काम करेगी। हमें बेहतर बनाने में मदद करने के लिए धन्यवाद!',
      'mr':
          'आमची टीम तुमच्या अहवालाचे पुनरावलोकन करेल आणि समस्येचे निराकरण करण्यासाठी काम करेल. आम्हाला सुधारण्यास मदत केल्याबद्दल धन्यवाद!',
      'pa':
          'ਸਾਡੀ ਟੀਮ ਤੁਹਾਡੀ ਰਿਪੋਰਟ ਦੀ ਸਮੀਖਿਆ ਕਰੇਗੀ ਅਤੇ ਸਮੱਸਿਆ ਨੂੰ ਹੱਲ ਕਰਨ ਲਈ ਕੰਮ ਕਰੇਗੀ। ਸੁਧਾਰ ਕਰਨ ਵਿੱਚ ਸਾਡੀ ਮਦਦ ਕਰਨ ਲਈ ਧੰਨਵਾਦ!',
    },
    'ydyew9cp': {
      'en': 'Report a Bug',
      'gu': 'બગની જાણ કરો',
      'hi': 'एक बग रिपोर्ट करो',
      'mr': 'बग नोंदवा',
      'pa': 'ਬੱਗ ਦੀ ਰਿਪੋਰਟ ਕਰੋ',
    },
    'nwh32g80': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // requestFeature
  {
    'bhdrygdb': {
      'en': 'Welcome ',
      'gu': 'સ્વાગત છે',
      'hi': 'स्वागत',
      'mr': 'स्वागत आहे',
      'pa': 'ਸਵਾਗਤ ਹੈ',
    },
    '4knx1mwv': {
      'en': '!',
      'gu': '!',
      'hi': '!',
      'mr': '!',
      'pa': '!',
    },
    '3degni2d': {
      'en': 'Share Your Ideas',
      'gu': 'તમારા વિચારો શેર કરો',
      'hi': 'अपने विचार साझा करें',
      'mr': 'तुमच्या कल्पना शेअर करा',
      'pa': 'ਆਪਣੇ ਵਿਚਾਰ ਸਾਂਝੇ ਕਰੋ',
    },
    '1uec0wfd': {
      'en': 'Help us improve by suggesting new features. We value your input!',
      'gu':
          'નવી સુવિધાઓ સૂચવીને અમને સુધારવામાં સહાય કરો. અમે તમારા અભિપ્રાયની કદર કરીએ છીએ!',
      'hi':
          'नई सुविधाएँ सुझाकर हमें बेहतर बनाने में मदद करें। हम आपके सुझावों की कद्र करते हैं!',
      'mr':
          'नवीन वैशिष्ट्ये सुचवून आम्हाला सुधारणा करण्यास मदत करा. तुमच्या सूचना आम्हाला महत्त्वाच्या आहेत!',
      'pa':
          'ਨਵੀਆਂ ਵਿਸ਼ੇਸ਼ਤਾਵਾਂ ਦਾ ਸੁਝਾਅ ਦੇ ਕੇ ਸਾਨੂੰ ਬਿਹਤਰ ਬਣਾਉਣ ਵਿੱਚ ਮਦਦ ਕਰੋ। ਅਸੀਂ ਤੁਹਾਡੇ ਸੁਝਾਅ ਦੀ ਕਦਰ ਕਰਦੇ ਹਾਂ!',
    },
    'mjj34qpi': {
      'en': 'Feature Details',
      'gu': 'સુવિધા વિગતો',
      'hi': 'विशेषता विवरण',
      'mr': 'वैशिष्ट्य तपशील',
      'pa': 'ਵਿਸ਼ੇਸ਼ਤਾ ਵੇਰਵੇ',
    },
    'on52zftu': {
      'en': 'Feature Title',
      'gu': 'સુવિધા શીર્ષક',
      'hi': 'फ़ीचर शीर्षक',
      'mr': 'वैशिष्ट्य शीर्षक',
      'pa': 'ਵਿਸ਼ੇਸ਼ਤਾ ਸਿਰਲੇਖ',
    },
    'bt1pf2zj': {
      'en': 'Give your feature a clear name',
      'gu': 'તમારા ફીચરને સ્પષ્ટ નામ આપો',
      'hi': 'अपनी सुविधा को स्पष्ट नाम दें',
      'mr': 'तुमच्या वैशिष्ट्याला एक स्पष्ट नाव द्या.',
      'pa': 'ਆਪਣੀ ਵਿਸ਼ੇਸ਼ਤਾ ਨੂੰ ਇੱਕ ਸਪਸ਼ਟ ਨਾਮ ਦਿਓ',
    },
    'u5xe9ulc': {
      'en': 'Description',
      'gu': 'વર્ણન',
      'hi': 'विवरण',
      'mr': 'वर्णन',
      'pa': 'ਵੇਰਵਾ',
    },
    '6t2rs8cg': {
      'en': 'Describe the feature and how it would help',
      'gu': 'સુવિધાનું વર્ણન કરો અને તે કેવી રીતે મદદ કરશે',
      'hi': 'विशेषता का वर्णन करें और बताएं कि यह कैसे मदद करेगी',
      'mr': 'वैशिष्ट्याचे वर्णन करा आणि ते कसे मदत करेल',
      'pa': 'ਵਿਸ਼ੇਸ਼ਤਾ ਦਾ ਵਰਣਨ ਕਰੋ ਅਤੇ ਇਹ ਕਿਵੇਂ ਮਦਦ ਕਰੇਗੀ',
    },
    'en3ypvaf': {
      'en': 'Category',
      'gu': 'શ્રેણી',
      'hi': 'वर्ग',
      'mr': 'श्रेणी',
      'pa': 'ਸ਼੍ਰੇਣੀ',
    },
    'htuz2sbd': {
      'en': 'UI/UX',
      'gu': 'યુઆઈ/યુએક્સ',
      'hi': 'यूआई/यूएक्स',
      'mr': 'यूआय/यूएक्स',
      'pa': 'ਯੂਆਈ/ਯੂਐਕਸ',
    },
    '8tltjzr1': {
      'en': 'Performance',
      'gu': 'પ્રદર્શન',
      'hi': 'प्रदर्शन',
      'mr': 'कामगिरी',
      'pa': 'ਪ੍ਰਦਰਸ਼ਨ',
    },
    'dj5thywy': {
      'en': 'Security',
      'gu': 'સુરક્ષા',
      'hi': 'सुरक्षा',
      'mr': 'सुरक्षा',
      'pa': 'ਸੁਰੱਖਿਆ',
    },
    '78brozkk': {
      'en': 'Translations',
      'gu': 'અનુવાદો',
      'hi': 'अनुवाद',
      'mr': 'भाषांतरे',
      'pa': 'ਅਨੁਵਾਦ',
    },
    'azmt50wy': {
      'en': 'Integrations',
      'gu': 'એકીકરણ',
      'hi': 'एकीकरण',
      'mr': 'एकत्रीकरण',
      'pa': 'ਏਕੀਕਰਨ',
    },
    'quyyjavj': {
      'en': 'Other',
      'gu': 'અન્ય',
      'hi': 'अन्य',
      'mr': 'इतर',
      'pa': 'ਹੋਰ',
    },
    'eqk9vr56': {
      'en': 'Priority Level',
      'gu': 'પ્રાથમિકતા સ્તર',
      'hi': 'प्राथमिकता स्तर',
      'mr': 'प्राधान्य पातळी',
      'pa': 'ਤਰਜੀਹੀ ਪੱਧਰ',
    },
    '6sakxljh': {
      'en': 'Low',
      'gu': 'નીચું',
      'hi': 'कम',
      'mr': 'कमी',
      'pa': 'ਘੱਟ',
    },
    '0hzntjhs': {
      'en': 'Medium',
      'gu': 'મધ્યમ',
      'hi': 'मध्यम',
      'mr': 'मध्यम',
      'pa': 'ਦਰਮਿਆਨਾ',
    },
    'qk2j6p6l': {
      'en': 'High',
      'gu': 'ઉચ્ચ',
      'hi': 'उच्च',
      'mr': 'उच्च',
      'pa': 'ਉੱਚ',
    },
    '9ew74cp1': {
      'en': 'Additional Information',
      'gu': 'વધારાની માહિતી',
      'hi': 'अतिरिक्त जानकारी',
      'mr': 'अतिरिक्त माहिती',
      'pa': 'ਵਧੀਕ ਜਾਣਕਾਰੀ',
    },
    'tdhixpi5': {
      'en': 'Use Case',
      'gu': 'ઉપયોગ કેસ',
      'hi': 'उदाहरण',
      'mr': 'वापर केस',
      'pa': 'ਵਰਤੋਂ ਦਾ ਮਾਮਲਾ',
    },
    'ipxsthd0': {
      'en': 'How would you use this feature?',
      'gu': 'તમે આ સુવિધાનો ઉપયોગ કેવી રીતે કરશો?',
      'hi': 'आप इस सुविधा का उपयोग कैसे करेंगे?',
      'mr': 'तुम्ही हे वैशिष्ट्य कसे वापराल?',
      'pa': 'ਤੁਸੀਂ ਇਸ ਵਿਸ਼ੇਸ਼ਤਾ ਦੀ ਵਰਤੋਂ ਕਿਵੇਂ ਕਰੋਗੇ?',
    },
    '0uo7by7z': {
      'en': 'Would you be willing to beta test?',
      'gu': 'શું તમે બીટા ટેસ્ટ કરવા તૈયાર છો?',
      'hi': 'क्या आप बीटा परीक्षण के लिए तैयार होंगे?',
      'mr': 'तुम्ही बीटा चाचणी करण्यास तयार आहात का?',
      'pa': 'ਕੀ ਤੁਸੀਂ ਬੀਟਾ ਟੈਸਟ ਕਰਨ ਲਈ ਤਿਆਰ ਹੋਵੋਗੇ?',
    },
    'qumqbxkg': {
      'en': 'Submit Request',
      'gu': 'વિનંતી સબમિટ કરો',
      'hi': 'अनुरोध सबमिट करें',
      'mr': 'विनंती सबमिट करा',
      'pa': 'ਬੇਨਤੀ ਜਮ੍ਹਾਂ ਕਰੋ',
    },
    '53uhwe5u': {
      'en': 'Feature Request',
      'gu': 'સુવિધા વિનંતી',
      'hi': 'सुविधा का अनुरोध',
      'mr': 'वैशिष्ट्य विनंती',
      'pa': 'ਵਿਸ਼ੇਸ਼ਤਾ ਬੇਨਤੀ',
    },
    'jbyj6h7z': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // supportPage
  {
    'tuip9173': {
      'en': 'Contact Support',
      'gu': 'સપોર્ટનો સંપર્ક કરો',
      'hi': 'समर्थन से संपर्क करें',
      'mr': 'सपोर्टशी संपर्क साधा',
      'pa': 'ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ',
    },
    'vpu74ss8': {
      'en': 'We\'re here to help! Choose how you\'d like to reach us.',
      'gu':
          'અમે મદદ કરવા માટે અહીં છીએ! તમે અમારો સંપર્ક કેવી રીતે કરવા માંગો છો તે પસંદ કરો.',
      'hi':
          'हम आपकी मदद के लिए यहाँ हैं! चुनें कि आप हमसे कैसे संपर्क करना चाहते हैं।',
      'mr':
          'आम्ही मदत करण्यासाठी येथे आहोत! तुम्हाला आमच्याशी कसे संपर्क साधायचा आहे ते निवडा.',
      'pa':
          'ਅਸੀਂ ਤੁਹਾਡੀ ਮਦਦ ਲਈ ਇੱਥੇ ਹਾਂ! ਚੁਣੋ ਕਿ ਤੁਸੀਂ ਸਾਡੇ ਤੱਕ ਕਿਵੇਂ ਪਹੁੰਚਣਾ ਚਾਹੁੰਦੇ ਹੋ।',
    },
    'wu5trhbj': {
      'en': 'Live Chat',
      'gu': 'લાઈવ ચેટ',
      'hi': 'सीधी बातचीत',
      'mr': 'थेट गप्पा',
      'pa': 'ਲਾਈਵ ਚੈਟ',
    },
    '6qwscyjh': {
      'en': 'Talk to us now',
      'gu': 'હમણાં જ અમારી સાથે વાત કરો',
      'hi': 'अभी हमसे बात करें',
      'mr': 'आता आमच्याशी बोला.',
      'pa': 'ਹੁਣੇ ਸਾਡੇ ਨਾਲ ਗੱਲ ਕਰੋ',
    },
    'i4azcylj': {
      'en': 'Email Us',
      'gu': 'અમને ઇમેઇલ કરો',
      'hi': 'हमें ईमेल करें',
      'mr': 'आम्हाला ईमेल करा',
      'pa': 'ਸਾਨੂੰ ਈਮੇਲ ਕਰੋ',
    },
    '9s9j3vmr': {
      'en': '24 hr response',
      'gu': '૨૪ કલાક પ્રતિભાવ',
      'hi': '24 घंटे प्रतिक्रिया',
      'mr': '२४ तास प्रतिसाद',
      'pa': '24 ਘੰਟੇ ਜਵਾਬ',
    },
    'vh92d7o5': {
      'en': 'Submit Feedback',
      'gu': 'પ્રતિસાદ સબમિટ કરો',
      'hi': 'प्रतिक्रिया सबमिट करें',
      'mr': 'अभिप्राय सबमिट करा',
      'pa': 'ਫੀਡਬੈਕ ਜਮ੍ਹਾਂ ਕਰੋ',
    },
    'u0ubjtq5': {
      'en': 'Subject',
      'gu': 'વિષય',
      'hi': 'विषय',
      'mr': 'विषय',
      'pa': 'ਵਿਸ਼ਾ',
    },
    'fkkw797e': {
      'en': 'Subject',
      'gu': 'વિષય',
      'hi': 'विषय',
      'mr': 'विषय',
      'pa': 'ਵਿਸ਼ਾ',
    },
    '3ooyjvpb': {
      'en': 'Feedback',
      'gu': 'પ્રતિસાદ',
      'hi': 'प्रतिक्रिया',
      'mr': 'अभिप्राय',
      'pa': 'ਫੀਡਬੈਕ',
    },
    'yvicwyy6': {
      'en': 'Your Feedback',
      'gu': 'તમારો પ્રતિભાવ',
      'hi': 'आपकी प्रतिक्रिया',
      'mr': 'तुमचा अभिप्राय',
      'pa': 'ਤੁਹਾਡਾ ਫੀਡਬੈਕ',
    },
    'ekirvxn3': {
      'en': 'Rate your experience',
      'gu': 'તમારા અનુભવને રેટ કરો',
      'hi': 'अपने अनुभव को रेटिंग दें',
      'mr': 'तुमचा अनुभव रेट करा',
      'pa': 'ਆਪਣੇ ਅਨੁਭਵ ਨੂੰ ਦਰਜਾ ਦਿਓ',
    },
    '2caispl7': {
      'en': 'Submit Feedback',
      'gu': 'પ્રતિસાદ સબમિટ કરો',
      'hi': 'प्रतिक्रिया सबमिट करें',
      'mr': 'अभिप्राय सबमिट करा',
      'pa': 'ਫੀਡਬੈਕ ਜਮ੍ਹਾਂ ਕਰੋ',
    },
    '4a3328v8': {
      'en': 'FAQs',
      'gu': 'પ્રશ્નો',
      'hi': 'पूछे जाने वाले प्रश्न',
      'mr': 'वारंवार विचारले जाणारे प्रश्न',
      'pa': 'ਅਕਸਰ ਪੁੱਛੇ ਜਾਂਦੇ ਸਵਾਲ',
    },
    'rtefp379': {
      'en': 'How do I reset my password?',
      'gu': 'હું મારો પાસવર્ડ કેવી રીતે રીસેટ કરી શકું?',
      'hi': 'मैं अपना पासवर्ड कैसे रीसेट करूं?',
      'mr': 'मी माझा पासवर्ड कसा रीसेट करू?',
      'pa': 'ਮੈਂ ਆਪਣਾ ਪਾਸਵਰਡ ਕਿਵੇਂ ਰੀਸੈਟ ਕਰਾਂ?',
    },
    'g4jvjfkt': {
      'en': 'How do I update my profile?',
      'gu': 'હું મારી પ્રોફાઇલ કેવી રીતે અપડેટ કરી શકું?',
      'hi': 'मैं अपनी प्रोफाइल को कैसे अपडेट करूँ?',
      'mr': 'मी माझे प्रोफाइल कसे अपडेट करू?',
      'pa': 'ਮੈਂ ਆਪਣਾ ਪ੍ਰੋਫਾਈਲ ਕਿਵੇਂ ਅੱਪਡੇਟ ਕਰਾਂ?',
    },
    'cuxkf0iz': {
      'en': 'How do I change my email?',
      'gu': 'હું મારું ઇમેઇલ કેવી રીતે બદલી શકું?',
      'hi': 'मैं अपना ईमेल कैसे बदलूं?',
      'mr': 'मी माझा ईमेल कसा बदलू?',
      'pa': 'ਮੈਂ ਆਪਣਾ ਈਮੇਲ ਕਿਵੇਂ ਬਦਲਾਂ?',
    },
    'oocq8hqr': {
      'en': 'Community & Resources',
      'gu': 'સમુદાય અને સંસાધનો',
      'hi': 'समुदाय और संसाधन',
      'mr': 'समुदाय आणि संसाधने',
      'pa': 'ਭਾਈਚਾਰਾ ਅਤੇ ਸਰੋਤ',
    },
    'feh2t3hg': {
      'en': 'Community Forum',
      'gu': 'સમુદાય મંચ',
      'hi': 'सामुदायिक मंच',
      'mr': 'समुदाय मंच',
      'pa': 'ਕਮਿਊਨਿਟੀ ਫੋਰਮ',
    },
    'xwy93fcj': {
      'en': 'Video Tutorials',
      'gu': 'વિડિઓ ટ્યુટોરિયલ્સ',
      'hi': 'वीडियो ट्यूटोरियल',
      'mr': 'व्हिडिओ ट्यूटोरियल',
      'pa': 'ਵੀਡੀਓ ਟਿਊਟੋਰਿਅਲ',
    },
    'cj4eenn0': {
      'en': 'User Guide',
      'gu': 'વપરાશકર્તા માર્ગદર્શિકા',
      'hi': 'उपयोगकर्ता गाइड',
      'mr': 'वापरकर्ता मार्गदर्शक',
      'pa': 'ਯੂਜ਼ਰ ਗਾਈਡ',
    },
    '4obc8kcv': {
      'en': 'Support & Feedback',
      'gu': 'સપોર્ટ અને પ્રતિસાદ',
      'hi': 'समर्थन और प्रतिक्रिया',
      'mr': 'समर्थन आणि अभिप्राय',
      'pa': 'ਸਹਾਇਤਾ ਅਤੇ ਫੀਡਬੈਕ',
    },
    'o3f6tcbr': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // tutorialPage
  {
    'sp7uv8ah': {
      'en': 'Welcome to Krishi 🌱',
      'gu': 'કૃષિમાં આપનું સ્વાગત છે 🌱',
      'hi': 'कृषि में आपका स्वागत है 🌱',
      'mr': 'कृषी मध्ये आपले स्वागत आहे 🌱',
      'pa': 'ਕ੍ਰਿਸ਼ੀ 🌱 ਵਿੱਚ ਤੁਹਾਡਾ ਸਵਾਗਤ ਹੈ',
    },
    '3boeqcfl': {
      'en':
          'Nurturing Nature with Technology. Get real-time insights and recommendations to optimize your farm\'s performance. Krishi is designed to help you monitor, analyze, and improve soil health with ease.',
      'gu':
          'ટેકનોલોજી વડે પ્રકૃતિનું પોષણ કરો. તમારા ખેતરના પ્રદર્શનને શ્રેષ્ઠ બનાવવા માટે વાસ્તવિક સમયની આંતરદૃષ્ટિ અને ભલામણો મેળવો. કૃષિ તમને સરળતાથી જમીનના સ્વાસ્થ્યનું નિરીક્ષણ, વિશ્લેષણ અને સુધારણા કરવામાં મદદ કરવા માટે રચાયેલ છે.',
      'hi':
          'प्रौद्योगिकी के साथ प्रकृति का पोषण करें। अपने खेत के प्रदर्शन को अनुकूलित करने के लिए वास्तविक समय की जानकारी और सिफारिशें प्राप्त करें। कृषि आपको आसानी से मिट्टी के स्वास्थ्य की निगरानी, ​​विश्लेषण और सुधार करने में मदद करने के लिए डिज़ाइन किया गया है।',
      'mr':
          'तंत्रज्ञानाच्या साहाय्याने निसर्गाचे संगोपन करणे. तुमच्या शेतीची कार्यक्षमता सुधारण्यासाठी रिअल-टाइम अंतर्दृष्टी आणि शिफारसी मिळवा. कृषी हे तुम्हाला मातीचे आरोग्य सहजतेने निरीक्षण, विश्लेषण आणि सुधारण्यास मदत करण्यासाठी डिझाइन केलेले आहे.',
      'pa':
          'ਤਕਨਾਲੋਜੀ ਨਾਲ ਕੁਦਰਤ ਦਾ ਪਾਲਣ-ਪੋਸ਼ਣ ਕਰੋ। ਆਪਣੇ ਫਾਰਮ ਦੀ ਕਾਰਗੁਜ਼ਾਰੀ ਨੂੰ ਅਨੁਕੂਲ ਬਣਾਉਣ ਲਈ ਅਸਲ-ਸਮੇਂ ਦੀਆਂ ਸੂਝਾਂ ਅਤੇ ਸਿਫ਼ਾਰਸ਼ਾਂ ਪ੍ਰਾਪਤ ਕਰੋ। ਕ੍ਰਿਸ਼ੀ ਨੂੰ ਮਿੱਟੀ ਦੀ ਸਿਹਤ ਦੀ ਨਿਗਰਾਨੀ, ਵਿਸ਼ਲੇਸ਼ਣ ਅਤੇ ਸੁਧਾਰ ਕਰਨ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰਨ ਲਈ ਤਿਆਰ ਕੀਤਾ ਗਿਆ ਹੈ।',
    },
    'ts14oxkq': {
      'en': 'Real-Time Sensor Monitoring',
      'gu': 'રીઅલ-ટાઇમ સેન્સર મોનિટરિંગ',
      'hi': 'वास्तविक समय सेंसर मॉनिटरिंग',
      'mr': 'रिअल-टाइम सेन्सर मॉनिटरिंग',
      'pa': 'ਰੀਅਲ-ਟਾਈਮ ਸੈਂਸਰ ਨਿਗਰਾਨੀ',
    },
    'a51ud4ke': {
      'en':
          'Instantly view live soil metrics—moisture, pH, and nutrient levels—directly from your device.',
      'gu':
          'તમારા ઉપકરણ પરથી સીધા જ માટીના લાઇવ મેટ્રિક્સ - ભેજ, pH અને પોષક સ્તર - તરત જ જુઓ.',
      'hi':
          'अपने डिवाइस से सीधे मृदा मेट्रिक्स - नमी, पीएच और पोषक तत्व स्तर - को तुरंत देखें।',
      'mr':
          'तुमच्या डिव्हाइसवरून थेट मातीचे मेट्रिक्स—ओलावा, पीएच आणि पोषक पातळी—तत्काळ पहा.',
      'pa':
          'ਆਪਣੀ ਡਿਵਾਈਸ ਤੋਂ ਸਿੱਧੇ ਤੌਰ \'ਤੇ ਮਿੱਟੀ ਦੇ ਲਾਈਵ ਮੈਟ੍ਰਿਕਸ—ਨਮੀ, pH, ਅਤੇ ਪੌਸ਼ਟਿਕ ਤੱਤਾਂ ਦੇ ਪੱਧਰ—ਤੁਰੰਤ ਦੇਖੋ।',
    },
    '7nkemv7n': {
      'en': 'Historical Data Insights',
      'gu': 'ઐતિહાસિક ડેટા આંતરદૃષ્ટિ',
      'hi': 'ऐतिहासिक डेटा अंतर्दृष्टि',
      'mr': 'ऐतिहासिक डेटा अंतर्दृष्टी',
      'pa': 'ਇਤਿਹਾਸਕ ਡੇਟਾ ਇਨਸਾਈਟਸ',
    },
    'u47iyvwa': {
      'en':
          'Explore trends over time with detailed reports and charts that help you track soil health.',
      'gu':
          'માટીના સ્વાસ્થ્યને ટ્રેક કરવામાં મદદ કરતા વિગતવાર અહેવાલો અને ચાર્ટ સાથે સમય જતાં વલણોનું અન્વેષણ કરો.',
      'hi':
          'विस्तृत रिपोर्ट और चार्ट के साथ समय के साथ रुझानों का पता लगाएं जो आपको मिट्टी के स्वास्थ्य पर नज़र रखने में मदद करते हैं।',
      'mr':
          'मातीच्या आरोग्याचा मागोवा घेण्यास मदत करणारे तपशीलवार अहवाल आणि चार्ट वापरून कालांतराने ट्रेंड एक्सप्लोर करा.',
      'pa':
          'ਮਿੱਟੀ ਦੀ ਸਿਹਤ ਨੂੰ ਟਰੈਕ ਕਰਨ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰਨ ਵਾਲੇ ਵਿਸਤ੍ਰਿਤ ਰਿਪੋਰਟਾਂ ਅਤੇ ਚਾਰਟਾਂ ਨਾਲ ਸਮੇਂ ਦੇ ਨਾਲ ਰੁਝਾਨਾਂ ਦੀ ਪੜਚੋਲ ਕਰੋ।',
    },
    'lranjb2x': {
      'en': 'AI-Powered Analysis',
      'gu': 'AI-સંચાલિત વિશ્લેષણ',
      'hi': 'एआई-संचालित विश्लेषण',
      'mr': 'एआय-चालित विश्लेषण',
      'pa': 'ਏਆਈ-ਪਾਵਰਡ ਵਿਸ਼ਲੇਸ਼ਣ',
    },
    '2huen4xn': {
      'en':
          'Receive actionable insights and recommendations based on AI analysis of your sensor data.',
      'gu':
          'તમારા સેન્સર ડેટાના AI વિશ્લેષણના આધારે કાર્યક્ષમ આંતરદૃષ્ટિ અને ભલામણો પ્રાપ્ત કરો.',
      'hi':
          'अपने सेंसर डेटा के AI विश्लेषण के आधार पर कार्रवाई योग्य जानकारी और सिफारिशें प्राप्त करें।',
      'mr':
          'तुमच्या सेन्सर डेटाच्या एआय विश्लेषणावर आधारित कृतीयोग्य अंतर्दृष्टी आणि शिफारसी प्राप्त करा.',
      'pa':
          'ਆਪਣੇ ਸੈਂਸਰ ਡੇਟਾ ਦੇ AI ਵਿਸ਼ਲੇਸ਼ਣ ਦੇ ਆਧਾਰ \'ਤੇ ਕਾਰਵਾਈਯੋਗ ਸੂਝ ਅਤੇ ਸਿਫ਼ਾਰਸ਼ਾਂ ਪ੍ਰਾਪਤ ਕਰੋ।',
    },
    'qk5f513v': {
      'en': 'Cloud Sync & Data Backup',
      'gu': 'ક્લાઉડ સિંક અને ડેટા બેકઅપ',
      'hi': 'क्लाउड सिंक और डेटा बैकअप',
      'mr': 'क्लाउड सिंक आणि डेटा बॅकअप',
      'pa': 'ਕਲਾਉਡ ਸਿੰਕ ਅਤੇ ਡਾਟਾ ਬੈਕਅੱਪ',
    },
    '3doxuff2': {
      'en':
          'Securely store, sync, and access your data from anywhere with robust cloud integration.',
      'gu':
          'મજબૂત ક્લાઉડ ઇન્ટિગ્રેશન સાથે ગમે ત્યાંથી તમારા ડેટાને સુરક્ષિત રીતે સ્ટોર કરો, સિંક કરો અને ઍક્સેસ કરો.',
      'hi':
          'मजबूत क्लाउड एकीकरण के साथ कहीं से भी अपने डेटा को सुरक्षित रूप से संग्रहीत, सिंक और एक्सेस करें।',
      'mr':
          'मजबूत क्लाउड इंटिग्रेशनसह कुठूनही तुमचा डेटा सुरक्षितपणे संग्रहित करा, समक्रमित करा आणि त्यात प्रवेश करा.',
      'pa':
          'ਮਜ਼ਬੂਤ ​​ਕਲਾਉਡ ਏਕੀਕਰਣ ਦੇ ਨਾਲ ਕਿਤੇ ਵੀ ਆਪਣੇ ਡੇਟਾ ਨੂੰ ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਸਟੋਰ ਕਰੋ, ਸਿੰਕ ਕਰੋ ਅਤੇ ਐਕਸੈਸ ਕਰੋ।',
    },
    '6jcdk428': {
      'en': 'Customizable Alerts & Notifications',
      'gu': 'કસ્ટમાઇઝ કરી શકાય તેવી ચેતવણીઓ અને સૂચનાઓ',
      'hi': 'अनुकूलन योग्य अलर्ट और अधिसूचनाएँ',
      'mr': 'सानुकूल करण्यायोग्य सूचना आणि सूचना',
      'pa': 'ਅਨੁਕੂਲਿਤ ਚੇਤਾਵਨੀਆਂ ਅਤੇ ਸੂਚਨਾਵਾਂ',
    },
    'wud9rqp2': {
      'en':
          'Set personalized thresholds and notifications for critical soil conditions to ensure ease of mind.',
      'gu':
          'મનની સરળતા સુનિશ્ચિત કરવા માટે ગંભીર માટીની સ્થિતિ માટે વ્યક્તિગત થ્રેશોલ્ડ અને સૂચનાઓ સેટ કરો.',
      'hi':
          'मन की शांति सुनिश्चित करने के लिए महत्वपूर्ण मृदा स्थितियों के लिए व्यक्तिगत सीमाएं और सूचनाएं निर्धारित करें।',
      'mr':
          'मनाची सोय सुनिश्चित करण्यासाठी गंभीर मातीच्या परिस्थितीसाठी वैयक्तिकृत मर्यादा आणि सूचना सेट करा.',
      'pa':
          'ਮਨ ਦੀ ਸੌਖ ਨੂੰ ਯਕੀਨੀ ਬਣਾਉਣ ਲਈ ਨਾਜ਼ੁਕ ਮਿੱਟੀ ਦੀਆਂ ਸਥਿਤੀਆਂ ਲਈ ਵਿਅਕਤੀਗਤ ਥ੍ਰੈਸ਼ਹੋਲਡ ਅਤੇ ਸੂਚਨਾਵਾਂ ਸੈੱਟ ਕਰੋ।',
    },
    'bygyl9qy': {
      'en': 'Local Supplier Connections',
      'gu': 'સ્થાનિક સપ્લાયર કનેક્શન્સ',
      'hi': 'स्थानीय आपूर्तिकर्ता कनेक्शन',
      'mr': 'स्थानिक पुरवठादार कनेक्शन',
      'pa': 'ਸਥਾਨਕ ਸਪਲਾਇਰ ਕਨੈਕਸ਼ਨ',
    },
    'bxj52c0f': {
      'en':
          'Seamlessly connect with local agricultural suppliers for timely resource support.',
      'gu':
          'સમયસર સંસાધન સહાય માટે સ્થાનિક કૃષિ સપ્લાયર્સ સાથે એકીકૃત રીતે જોડાઓ.',
      'hi':
          'समय पर संसाधन सहायता के लिए स्थानीय कृषि आपूर्तिकर्ताओं से सहजता से जुड़ें।',
      'mr':
          'वेळेवर संसाधन समर्थनासाठी स्थानिक कृषी पुरवठादारांशी अखंडपणे कनेक्ट व्हा.',
      'pa':
          'ਸਮੇਂ ਸਿਰ ਸਰੋਤ ਸਹਾਇਤਾ ਲਈ ਸਥਾਨਕ ਖੇਤੀਬਾੜੀ ਸਪਲਾਇਰਾਂ ਨਾਲ ਸਹਿਜੇ ਹੀ ਜੁੜੋ।',
    },
    '50reiwot': {
      'en': 'Be aware of new rules and schemes in farming',
      'gu': 'ખેતીમાં નવા નિયમો અને યોજનાઓથી વાકેફ રહો',
      'hi': 'खेती में नए नियमों और योजनाओं से अवगत रहें',
      'mr': 'शेतीतील नवीन नियम आणि योजनांविषयी जागरूक रहा.',
      'pa': 'ਖੇਤੀ ਵਿੱਚ ਨਵੇਂ ਨਿਯਮਾਂ ਅਤੇ ਯੋਜਨਾਵਾਂ ਤੋਂ ਜਾਣੂ ਰਹੋ',
    },
    '4a0u9b3l': {
      'en':
          'Stay informed about subsidies and support programs tailored to promote sustainable and modern farming practices.',
      'gu':
          'ટકાઉ અને આધુનિક ખેતી પદ્ધતિઓને પ્રોત્સાહન આપવા માટે તૈયાર કરાયેલા સબસિડી અને સહાય કાર્યક્રમો વિશે માહિતગાર રહો.',
      'hi':
          'टिकाऊ और आधुनिक कृषि पद्धतियों को बढ़ावा देने के लिए तैयार की गई सब्सिडी और सहायता कार्यक्रमों के बारे में जानकारी रखें।',
      'mr':
          'शाश्वत आणि आधुनिक शेती पद्धतींना प्रोत्साहन देण्यासाठी तयार केलेल्या अनुदाने आणि समर्थन कार्यक्रमांबद्दल माहिती मिळवा.',
      'pa':
          'ਟਿਕਾਊ ਅਤੇ ਆਧੁਨਿਕ ਖੇਤੀ ਅਭਿਆਸਾਂ ਨੂੰ ਉਤਸ਼ਾਹਿਤ ਕਰਨ ਲਈ ਤਿਆਰ ਕੀਤੀਆਂ ਗਈਆਂ ਸਬਸਿਡੀਆਂ ਅਤੇ ਸਹਾਇਤਾ ਪ੍ਰੋਗਰਾਮਾਂ ਬਾਰੇ ਜਾਣੂ ਰਹੋ।',
    },
    'w5ks3mbq': {
      'en': 'Account Page - Your Space, Your Way',
      'gu': 'એકાઉન્ટ પેજ - તમારી જગ્યા, તમારી રીતે',
      'hi': 'खाता पृष्ठ - आपका स्थान, आपकी राह',
      'mr': 'खाते पृष्ठ - तुमची जागा, तुमचा मार्ग',
      'pa': 'ਖਾਤਾ ਪੰਨਾ - ਤੁਹਾਡੀ ਜਗ੍ਹਾ, ਤੁਹਾਡਾ ਰਸਤਾ',
    },
    '55qtqgsp': {
      'en':
          'Update your name, email, and profile picture.\nChoose your preferred language, font size, and theme (light/dark mode).',
      'gu':
          'તમારું નામ, ઇમેઇલ અને પ્રોફાઇલ ચિત્ર અપડેટ કરો.\nતમારી પસંદગીની ભાષા, ફોન્ટનું કદ અને થીમ (લાઇટ/ડાર્ક મોડ) પસંદ કરો.',
      'hi':
          'अपना नाम, ईमेल और प्रोफ़ाइल चित्र अपडेट करें।\nअपनी पसंदीदा भाषा, फ़ॉन्ट आकार और थीम (लाइट/डार्क मोड) चुनें।',
      'mr':
          'तुमचे नाव, ईमेल आणि प्रोफाइल चित्र अपडेट करा.\nतुमची पसंतीची भाषा, फॉन्ट आकार आणि थीम (लाइट/डार्क मोड) निवडा.',
      'pa':
          'ਆਪਣਾ ਨਾਮ, ਈਮੇਲ ਅਤੇ ਪ੍ਰੋਫਾਈਲ ਤਸਵੀਰ ਅੱਪਡੇਟ ਕਰੋ।\nਆਪਣੀ ਪਸੰਦੀਦਾ ਭਾਸ਼ਾ, ਫੌਂਟ ਆਕਾਰ ਅਤੇ ਥੀਮ (ਹਲਕਾ/ਡਾਰਕ ਮੋਡ) ਚੁਣੋ।',
    },
    'js74tekv': {
      'en': 'App Settings Page - Personalize Your Experience',
      'gu': 'એપ્લિકેશન સેટિંગ્સ પૃષ્ઠ - તમારા અનુભવને વ્યક્તિગત કરો',
      'hi': 'ऐप सेटिंग पेज - अपना अनुभव निजीकृत करें',
      'mr': 'अ‍ॅप सेटिंग्ज पृष्ठ - तुमचा अनुभव वैयक्तिकृत करा',
      'pa': 'ਐਪ ਸੈਟਿੰਗਾਂ ਪੰਨਾ - ਆਪਣੇ ਅਨੁਭਵ ਨੂੰ ਨਿੱਜੀ ਬਣਾਓ',
    },
    'w854vzgm': {
      'en':
          'Adjust language, themes, and accessibility options to make the app work best for you.',
      'gu':
          'એપ્લિકેશન તમારા માટે શ્રેષ્ઠ રીતે કાર્ય કરે તે માટે ભાષા, થીમ્સ અને ઍક્સેસિબિલિટી વિકલ્પોને સમાયોજિત કરો.',
      'hi':
          'ऐप को आपके लिए सर्वोत्तम बनाने के लिए भाषा, थीम और पहुँच विकल्पों को समायोजित करें.',
      'mr':
          'अॅप तुमच्यासाठी सर्वोत्तम काम करण्यासाठी भाषा, थीम आणि प्रवेशयोग्यता पर्याय समायोजित करा.',
      'pa':
          'ਐਪ ਨੂੰ ਤੁਹਾਡੇ ਲਈ ਸਭ ਤੋਂ ਵਧੀਆ ਬਣਾਉਣ ਲਈ ਭਾਸ਼ਾ, ਥੀਮ ਅਤੇ ਪਹੁੰਚਯੋਗਤਾ ਵਿਕਲਪਾਂ ਨੂੰ ਵਿਵਸਥਿਤ ਕਰੋ।',
    },
    'ecg4m2ct': {
      'en': 'Help & Support Page - We’re Here to Help',
      'gu': 'મદદ અને સપોર્ટ પેજ - અમે મદદ કરવા માટે અહીં છીએ',
      'hi': 'सहायता एवं समर्थन पृष्ठ - हम सहायता के लिए यहाँ हैं',
      'mr': 'मदत आणि समर्थन पृष्ठ - आम्ही मदत करण्यासाठी येथे आहोत',
      'pa': 'ਮਦਦ ਅਤੇ ਸਹਾਇਤਾ ਪੰਨਾ - ਅਸੀਂ ਮਦਦ ਲਈ ਇੱਥੇ ਹਾਂ',
    },
    '1n1oyrvs': {
      'en':
          'Get answers to common questions.\nNeed help? Reach out to our support team.\nShare your thoughts to help us improve.',
      'gu':
          'સામાન્ય પ્રશ્નોના જવાબો મેળવો.\nમદદની જરૂર છે? અમારી સપોર્ટ ટીમનો સંપર્ક કરો.\nઅમને સુધારવામાં મદદ કરવા માટે તમારા વિચારો શેર કરો.',
      'hi':
          'सामान्य प्रश्नों के उत्तर प्राप्त करें।\nसहायता चाहिए? हमारी सहायता टीम से संपर्क करें।\nहमें बेहतर बनाने में मदद करने के लिए अपने विचार साझा करें।',
      'mr':
          'सामान्य प्रश्नांची उत्तरे मिळवा.\nमदत हवी आहे का? आमच्या सपोर्ट टीमशी संपर्क साधा.\nआम्हाला सुधारण्यास मदत करण्यासाठी तुमचे विचार शेअर करा.',
      'pa':
          'ਆਮ ਸਵਾਲਾਂ ਦੇ ਜਵਾਬ ਪ੍ਰਾਪਤ ਕਰੋ।\nਕੀ ਤੁਹਾਨੂੰ ਮਦਦ ਦੀ ਲੋੜ ਹੈ? ਸਾਡੀ ਸਹਾਇਤਾ ਟੀਮ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।\nਸਾਨੂੰ ਬਿਹਤਰ ਬਣਾਉਣ ਵਿੱਚ ਮਦਦ ਕਰਨ ਲਈ ਆਪਣੇ ਵਿਚਾਰ ਸਾਂਝੇ ਕਰੋ।',
    },
    'nf2ybzwf': {
      'en': 'Report Bug Page - Your Voice Matters',
      'gu': 'રિપોર્ટ બગ પેજ - તમારો અવાજ મહત્વપૂર્ણ છે',
      'hi': 'बग रिपोर्ट करें पेज - आपकी आवाज़ मायने रखती है',
      'mr': 'बग पेजची तक्रार करा - तुमचा आवाज महत्त्वाचा आहे',
      'pa': 'ਰਿਪੋਰਟ ਬੱਗ ਪੰਨਾ - ਤੁਹਾਡੀ ਆਵਾਜ਼ ਮਾਇਨੇ ਰੱਖਦੀ ਹੈ',
    },
    'wfih3wok': {
      'en':
          'Share your thoughts, suggestions, bugs or concerns to help us make the app better.',
      'gu':
          'એપ્લિકેશનને વધુ સારી બનાવવામાં અમારી સહાય કરવા માટે તમારા વિચારો, સૂચનો, ભૂલો અથવા ચિંતાઓ શેર કરો.',
      'hi':
          'ऐप को बेहतर बनाने में हमारी मदद करने के लिए अपने विचार, सुझाव, बग या चिंताएं साझा करें।',
      'mr':
          'अॅप अधिक चांगले बनवण्यासाठी तुमचे विचार, सूचना, बग किंवा चिंता शेअर करा.',
      'pa':
          'ਐਪ ਨੂੰ ਬਿਹਤਰ ਬਣਾਉਣ ਵਿੱਚ ਸਾਡੀ ਮਦਦ ਕਰਨ ਲਈ ਆਪਣੇ ਵਿਚਾਰ, ਸੁਝਾਅ, ਬੱਗ ਜਾਂ ਚਿੰਤਾਵਾਂ ਸਾਂਝੀਆਂ ਕਰੋ।',
    },
    '5q43zibh': {
      'en': 'Tutorial',
      'gu': 'ટ્યુટોરીયલ',
      'hi': 'ट्यूटोरियल',
      'mr': 'ट्यूटोरियल',
      'pa': 'ਟਿਊਟੋਰਿਅਲ',
    },
    'rm10pjp5': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // selectLanguage
  {
    'qgtb65uk': {
      'en': 'Krishi',
      'gu': 'કૃષિ',
      'hi': 'कृषि',
      'mr': 'कृषी',
      'pa': 'ਕ੍ਰਿਸ਼ੀ',
    },
    'wczm6h8v': {
      'en': 'Harvesting Hope',
      'gu': 'આશાનો પાક',
      'hi': 'आशा की फसल',
      'mr': 'आशा निर्माण करणे',
      'pa': 'ਵਾਢੀ ਦੀ ਉਮੀਦ',
    },
    '6aa76eq1': {
      'en': 'Choose your language',
      'gu': 'તમારી ભાષા પસંદ કરો',
      'hi': 'अपनी भाषा चुनें',
      'mr': 'तुमची भाषा निवडा',
      'pa': 'ਆਪਣੀ ਭਾਸ਼ਾ ਚੁਣੋ',
    },
    'pi0nr520': {
      'en':
          'Choose your preferred language to personalize your app experience. You can change it anytime in the settings.',
      'gu':
          'તમારા એપ્લિકેશન અનુભવને વ્યક્તિગત કરવા માટે તમારી પસંદગીની ભાષા પસંદ કરો. તમે સેટિંગ્સમાં ગમે ત્યારે તેને બદલી શકો છો.',
      'hi':
          'अपने ऐप अनुभव को निजीकृत करने के लिए अपनी पसंदीदा भाषा चुनें। आप इसे सेटिंग में कभी भी बदल सकते हैं।',
      'mr':
          'तुमचा अ‍ॅप अनुभव वैयक्तिकृत करण्यासाठी तुमची पसंतीची भाषा निवडा. तुम्ही सेटिंग्जमध्ये कधीही ती बदलू शकता.',
      'pa':
          'ਆਪਣੇ ਐਪ ਅਨੁਭਵ ਨੂੰ ਵਿਅਕਤੀਗਤ ਬਣਾਉਣ ਲਈ ਆਪਣੀ ਪਸੰਦੀਦਾ ਭਾਸ਼ਾ ਚੁਣੋ। ਤੁਸੀਂ ਇਸਨੂੰ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਕਿਸੇ ਵੀ ਸਮੇਂ ਬਦਲ ਸਕਦੇ ਹੋ।',
    },
    '6o1o2v7a': {
      'en': 'Save',
      'gu': 'સાચવો',
      'hi': 'बचाना',
      'mr': 'जतन करा',
      'pa': 'ਸੇਵ ਕਰੋ',
    },
    '48pnsx5u': {
      'en':
          'Disclaimer: The app translation has been provided by the IEEE SIGHT Group Development Team. If you notice any mistakes or discrepancies in the translations, please do not hesitate to reach out to us. You can contact support, raise a help query within the app, or email us at prabhjotassi16@gmail.com.',
      'gu':
          'ડિસ્ક્લેમર: એપ્લિકેશન અનુવાદ IEEE SIGHT ગ્રુપ ડેવલપમેન્ટ ટીમ દ્વારા પ્રદાન કરવામાં આવ્યો છે. જો તમને અનુવાદોમાં કોઈ ભૂલો અથવા વિસંગતતા દેખાય, તો કૃપા કરીને અમારો સંપર્ક કરવામાં અચકાશો નહીં. તમે સપોર્ટનો સંપર્ક કરી શકો છો, એપ્લિકેશનમાં મદદ માટે પ્રશ્ન પૂછી શકો છો અથવા અમને prabhjotassi16@gmail.com પર ઇમેઇલ કરી શકો છો.',
      'hi':
          'अस्वीकरण: ऐप अनुवाद IEEE SIGHT ग्रुप डेवलपमेंट टीम द्वारा प्रदान किया गया है। यदि आपको अनुवाद में कोई गलती या विसंगतियां दिखती हैं, तो कृपया हमसे संपर्क करने में संकोच न करें। आप सहायता से संपर्क कर सकते हैं, ऐप के भीतर सहायता संबंधी प्रश्न उठा सकते हैं, या हमें prabhjotassi16@gmail.com पर ईमेल कर सकते हैं।',
      'mr':
          'अस्वीकरण: अ‍ॅप भाषांतर IEEE SIGHT ग्रुप डेव्हलपमेंट टीमने प्रदान केले आहे. जर तुम्हाला भाषांतरांमध्ये काही चुका किंवा विसंगती आढळल्या तर कृपया आमच्याशी संपर्क साधण्यास अजिबात संकोच करू नका. तुम्ही सपोर्टशी संपर्क साधू शकता, अ‍ॅपमध्ये मदतीची विनंती करू शकता किंवा prabhjotassi16@gmail.com वर आम्हाला ईमेल करू शकता.',
      'pa':
          'ਬੇਦਾਅਵਾ: ਐਪ ਅਨੁਵਾਦ IEEE SIGHT ਗਰੁੱਪ ਡਿਵੈਲਪਮੈਂਟ ਟੀਮ ਦੁਆਰਾ ਪ੍ਰਦਾਨ ਕੀਤਾ ਗਿਆ ਹੈ। ਜੇਕਰ ਤੁਹਾਨੂੰ ਅਨੁਵਾਦਾਂ ਵਿੱਚ ਕੋਈ ਗਲਤੀ ਜਾਂ ਅੰਤਰ ਨਜ਼ਰ ਆਉਂਦਾ ਹੈ, ਤਾਂ ਕਿਰਪਾ ਕਰਕੇ ਸਾਡੇ ਨਾਲ ਸੰਪਰਕ ਕਰਨ ਤੋਂ ਝਿਜਕੋ ਨਾ। ਤੁਸੀਂ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰ ਸਕਦੇ ਹੋ, ਐਪ ਦੇ ਅੰਦਰ ਮਦਦ ਪੁੱਛਗਿੱਛ ਕਰ ਸਕਦੇ ਹੋ, ਜਾਂ ਸਾਨੂੰ prabhjotassi16@gmail.com \'ਤੇ ਈਮੇਲ ਕਰ ਸਕਦੇ ਹੋ।',
    },
    'hb16ph3q': {
      'en': 'Home',
      'gu': 'ઘર',
      'hi': 'घर',
      'mr': 'मुखपृष्ठ',
      'pa': 'ਮੁੱਖ ਪੇਜ',
    },
  },
  // datamanagePage
  {
    '4b8a9qsv': {
      'en': 'Manage your sensor data and reports with these tools:',
      'gu': 'આ સાધનો વડે તમારા સેન્સર ડેટા અને રિપોર્ટ્સનું સંચાલન કરો:',
      'hi': 'इन उपकरणों से अपने सेंसर डेटा और रिपोर्ट प्रबंधित करें:',
      'mr': 'या साधनांसह तुमचा सेन्सर डेटा आणि अहवाल व्यवस्थापित करा:',
      'pa': 'ਇਹਨਾਂ ਸਾਧਨਾਂ ਨਾਲ ਆਪਣੇ ਸੈਂਸਰ ਡੇਟਾ ਅਤੇ ਰਿਪੋਰਟਾਂ ਦਾ ਪ੍ਰਬੰਧਨ ਕਰੋ:',
    },
    'f7qb4o6n': {
      'en': 'Data Backup',
      'gu': 'ડેટા બેકઅપ',
      'hi': 'डेटा बैकअप',
      'mr': 'डेटा बॅकअप',
      'pa': 'ਡਾਟਾ ਬੈਕਅੱਪ',
    },
    'ia83brw9': {
      'en': 'Securely back up your sensor data locally\n or to the cloud.',
      'gu':
          'તમારા સેન્સર ડેટાનો સ્થાનિક રીતે અથવા ક્લાઉડ પર સુરક્ષિત રીતે બેકઅપ લો.',
      'hi':
          'अपने सेंसर डेटा का स्थानीय रूप से या क्लाउड पर सुरक्षित रूप से बैकअप लें।',
      'mr':
          'तुमच्या सेन्सर डेटाचा स्थानिक पातळीवर किंवा क्लाउडवर सुरक्षितपणे बॅकअप घ्या.',
      'pa':
          'ਆਪਣੇ ਸੈਂਸਰ ਡੇਟਾ ਦਾ ਸਥਾਨਕ ਤੌਰ \'ਤੇ ਜਾਂ ਕਲਾਉਡ \'ਤੇ ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਬੈਕਅੱਪ ਲਓ।',
    },
    'udjhqxey': {
      'en': 'Auto-backup',
      'gu': 'સ્વતઃ-બેકઅપ',
      'hi': 'ऑटो-बैकअप',
      'mr': 'ऑटो-बॅकअप',
      'pa': 'ਆਟੋ-ਬੈਕਅੱਪ',
    },
    'fh2wnc5u': {
      'en': 'Manual Backup',
      'gu': 'મેન્યુઅલ બેકઅપ',
      'hi': 'मैनुअल बैकअप',
      'mr': 'मॅन्युअल बॅकअप',
      'pa': 'ਮੈਨੁਅਲ ਬੈਕਅੱਪ',
    },
    'j2kv4kks': {
      'en': 'Export Historical Reports',
      'gu': 'ઐતિહાસિક અહેવાલો નિકાસ કરો',
      'hi': 'ऐतिहासिक रिपोर्ट निर्यात करें',
      'mr': 'ऐतिहासिक अहवाल निर्यात करा',
      'pa': 'ਇਤਿਹਾਸਕ ਰਿਪੋਰਟਾਂ ਨਿਰਯਾਤ ਕਰੋ',
    },
    '4qg5jbm4': {
      'en': 'Download detailed reports to track \ntrends over time.',
      'gu': 'સમય જતાં વલણોને ટ્રેક કરવા માટે વિગતવાર રિપોર્ટ્સ ડાઉનલોડ કરો.',
      'hi':
          'समय के साथ रुझानों पर नज़र रखने के लिए विस्तृत रिपोर्ट डाउनलोड करें।',
      'mr': 'काळानुसार ट्रेंडचा मागोवा घेण्यासाठी तपशीलवार अहवाल डाउनलोड करा.',
      'pa':
          'ਸਮੇਂ ਦੇ ਨਾਲ ਰੁਝਾਨਾਂ ਨੂੰ ਟਰੈਕ ਕਰਨ ਲਈ ਵਿਸਤ੍ਰਿਤ ਰਿਪੋਰਟਾਂ ਡਾਊਨਲੋਡ ਕਰੋ।',
    },
    'd8erhcvv': {
      'en': 'Select format',
      'gu': 'ફોર્મેટ પસંદ કરો',
      'hi': 'प्रारूप चुनें',
      'mr': 'फॉरमॅट निवडा',
      'pa': 'ਫਾਰਮੈਟ ਚੁਣੋ',
    },
    'gl2rl04e': {
      'en': 'Search...',
      'gu': 'શોધો...',
      'hi': 'खोज...',
      'mr': 'शोधा...',
      'pa': 'ਖੋਜ...',
    },
    'lnictla3': {
      'en': 'CSV',
      'gu': 'સીએસવી',
      'hi': 'सीएसवी',
      'mr': 'सीएसव्ही',
      'pa': 'ਸੀਐਸਵੀ',
    },
    'sprx4d6h': {
      'en': 'PDF',
      'gu': 'પીડીએફ',
      'hi': 'पीडीएफ',
      'mr': 'पीडीएफ',
      'pa': 'PDF',
    },
    '6bxisgsv': {
      'en': 'Excel',
      'gu': 'એક્સેલ',
      'hi': 'एक्सेल',
      'mr': 'एक्सेल',
      'pa': 'ਐਕਸਲ',
    },
    '1wfle0r0': {
      'en': 'Export',
      'gu': 'નિકાસ કરો',
      'hi': 'निर्यात',
      'mr': 'निर्यात करा',
      'pa': 'ਨਿਰਯਾਤ ਕਰੋ',
    },
    'q4e6cwqs': {
      'en': 'Cloud Connectivity',
      'gu': 'ક્લાઉડ કનેક્ટિવિટી',
      'hi': 'क्लाउड कनेक्टिविटी',
      'mr': 'क्लाउड कनेक्टिव्हिटी',
      'pa': 'ਕਲਾਉਡ ਕਨੈਕਟੀਵਿਟੀ',
    },
    'zjjaphsn': {
      'en': 'Sync and access your data from anywhere.',
      'gu': 'ગમે ત્યાંથી તમારા ડેટાને સમન્વયિત કરો અને ઍક્સેસ કરો.',
      'hi': 'कहीं से भी अपने डेटा को सिंक और एक्सेस करें।',
      'mr': 'कुठूनही तुमचा डेटा सिंक करा आणि त्यात प्रवेश करा.',
      'pa': 'ਕਿਤੇ ਵੀ ਆਪਣੇ ਡੇਟਾ ਨੂੰ ਸਿੰਕ ਕਰੋ ਅਤੇ ਐਕਸੈਸ ਕਰੋ।',
    },
    '1x9s063d': {
      'en': 'Manage Connection',
      'gu': 'કનેક્શન મેનેજ કરો',
      'hi': 'कनेक्शन प्रबंधित करें',
      'mr': 'कनेक्शन व्यवस्थापित करा',
      'pa': 'ਕਨੈਕਸ਼ਨ ਪ੍ਰਬੰਧਿਤ ਕਰੋ',
    },
    '6dct2tfu': {
      'en': 'Data Management',
      'gu': 'ડેટા મેનેજમેન્ટ',
      'hi': 'डेटा प्रबंधन',
      'mr': 'डेटा व्यवस्थापन',
      'pa': 'ਡਾਟਾ ਪ੍ਰਬੰਧਨ',
    },
  },
  // sensoralertPage
  {
    'cxvpxqr9': {
      'en': 'Sensor & Soil Scan Alert Settings',
      'gu': 'સેન્સર અને સોઇલ સ્કેન ચેતવણી સેટિંગ્સ',
      'hi': 'सेंसर और मृदा स्कैन अलर्ट सेटिंग्स',
      'mr': 'सेन्सर आणि माती स्कॅन अलर्ट सेटिंग्ज',
      'pa': 'ਸੈਂਸਰ ਅਤੇ ਮਿੱਟੀ ਸਕੈਨ ਚੇਤਾਵਨੀ ਸੈਟਿੰਗਾਂ',
    },
    '6zhc98t5': {
      'en': 'Calibration Controls',
      'gu': 'માપાંકન નિયંત્રણો',
      'hi': 'अंशांकन नियंत्रण',
      'mr': 'कॅलिब्रेशन नियंत्रणे',
      'pa': 'ਕੈਲੀਬ੍ਰੇਸ਼ਨ ਕੰਟਰੋਲ',
    },
    'q519m8n7': {
      'en': 'Calibrate your sensors for optimal accuracy.',
      'gu': 'શ્રેષ્ઠ ચોકસાઈ માટે તમારા સેન્સરને માપાંકિત કરો.',
      'hi': 'इष्टतम सटीकता के लिए अपने सेंसरों को कैलिब्रेट करें।',
      'mr': 'इष्टतम अचूकतेसाठी तुमचे सेन्सर्स कॅलिब्रेट करा.',
      'pa': 'ਅਨੁਕੂਲ ਸ਼ੁੱਧਤਾ ਲਈ ਆਪਣੇ ਸੈਂਸਰਾਂ ਨੂੰ ਕੈਲੀਬਰੇਟ ਕਰੋ।',
    },
    'sdwoc19e': {
      'en': 'Moisture Sensor',
      'gu': 'ભેજ સેન્સર',
      'hi': 'नमी सेंसर',
      'mr': 'ओलावा सेन्सर',
      'pa': 'ਨਮੀ ਸੈਂਸਰ',
    },
    'kmxlju94': {
      'en': 'Nutrient Sensor',
      'gu': 'પોષક સંવેદક',
      'hi': 'पोषक तत्व सेंसर',
      'mr': 'पोषक तत्वांचा सेन्सर',
      'pa': 'ਪੌਸ਼ਟਿਕ ਤੱਤ ਸੂਚਕ',
    },
    'up5hezay': {
      'en': 'pH Sensor',
      'gu': 'pH સેન્સર',
      'hi': 'पीएच सेंसर',
      'mr': 'पीएच सेन्सर',
      'pa': 'pH ਸੈਂਸਰ',
    },
    'cmwzge4o': {
      'en': 'Reset to Default Calibration',
      'gu': 'ડિફોલ્ટ કેલિબ્રેશન પર રીસેટ કરો',
      'hi': 'डिफ़ॉल्ट कैलिब्रेशन पर रीसेट करें',
      'mr': 'डीफॉल्ट कॅलिब्रेशनवर रीसेट करा',
      'pa': 'ਡਿਫੌਲਟ ਕੈਲੀਬ੍ਰੇਸ਼ਨ \'ਤੇ ਰੀਸੈਟ ਕਰੋ',
    },
    'u4nuzjgu': {
      'en': 'Data Sampling Intervals',
      'gu': 'ડેટા સેમ્પલિંગ અંતરાલો',
      'hi': 'डेटा नमूनाकरण अंतराल',
      'mr': 'डेटा सॅम्पलिंग मध्यांतर',
      'pa': 'ਡਾਟਾ ਸੈਂਪਲਿੰਗ ਅੰਤਰਾਲ',
    },
    'ghr4guvj': {
      'en':
          'Set sampling intervals (in seconds) to balance precision and power usage',
      'gu':
          'ચોકસાઇ અને પાવર વપરાશને સંતુલિત કરવા માટે નમૂના અંતરાલો (સેકંડમાં) સેટ કરો',
      'hi':
          'परिशुद्धता और बिजली उपयोग को संतुलित करने के लिए नमूना अंतराल (सेकंड में) सेट करें',
      'mr':
          'अचूकता आणि वीज वापर संतुलित करण्यासाठी नमुना अंतराल (सेकंदात) सेट करा.',
      'pa':
          'ਸ਼ੁੱਧਤਾ ਅਤੇ ਪਾਵਰ ਵਰਤੋਂ ਨੂੰ ਸੰਤੁਲਿਤ ਕਰਨ ਲਈ ਸੈਂਪਲਿੰਗ ਅੰਤਰਾਲ (ਸਕਿੰਟਾਂ ਵਿੱਚ) ਸੈੱਟ ਕਰੋ',
    },
    'cuj5srtc': {
      'en': 'Sampling Interval',
      'gu': 'નમૂના લેવાનો અંતરાલ',
      'hi': 'नमूना अंतराल',
      'mr': 'नमुना अंतराल',
      'pa': 'ਸੈਂਪਲਿੰਗ ਅੰਤਰਾਲ',
    },
    'dzd87vh3': {
      'en': '30 sec',
      'gu': '૩૦ સેકન્ડ',
      'hi': '30 सेकंड',
      'mr': '३० सेकंद',
      'pa': '30 ਸਕਿੰਟ',
    },
    '9j1x5bnn': {
      'en': '5s',
      'gu': '5 સે',
      'hi': '5एस',
      'mr': '५ सेकंद',
      'pa': '5 ਸਕਿੰਟ',
    },
    'ogmt5nq0': {
      'en': '60s',
      'gu': '૬૦નો દશક',
      'hi': '60',
      'mr': '६० चे दशक',
      'pa': '60 ਦਾ ਦਹਾਕਾ',
    },
    'efvn9iwt': {
      'en': '120s',
      'gu': '૧૨૦નો દાયકા',
      'hi': '120 से',
      'mr': '१२० चे दशक',
      'pa': '120 ਦਾ ਦਹਾਕਾ',
    },
    'cg7b6gpg': {
      'en': 'Power Saving Mode',
      'gu': 'પાવર સેવિંગ મોડ',
      'hi': 'बिजली की बचत अवस्था',
      'mr': 'पॉवर सेव्हिंग मोड',
      'pa': 'ਪਾਵਰ ਸੇਵਿੰਗ ਮੋਡ',
    },
    'qthv7hqb': {
      'en': 'Extends intervals when inactive',
      'gu': 'નિષ્ક્રિય હોય ત્યારે અંતરાલો લંબાવે છે',
      'hi': 'निष्क्रिय होने पर अंतराल बढ़ाता है',
      'mr': 'निष्क्रिय असताना मध्यांतर वाढवते',
      'pa': 'ਜਦੋਂ ਨਿਸ਼ਕਿਰਿਆ ਹੋਵੇ ਤਾਂ ਅੰਤਰਾਲ ਵਧਾਉਂਦਾ ਹੈ',
    },
    'r93dx3vk': {
      'en': 'Alert Management',
      'gu': 'ચેતવણી વ્યવસ્થાપન',
      'hi': 'अलर्ट प्रबंधन',
      'mr': 'अलर्ट व्यवस्थापन',
      'pa': 'ਚੇਤਾਵਨੀ ਪ੍ਰਬੰਧਨ',
    },
    '4fr8s8k7': {
      'en': 'Enable notifications for soil conditions and sensor readings',
      'gu': 'માટીની સ્થિતિ અને સેન્સર રીડિંગ્સ માટે સૂચનાઓ સક્ષમ કરો',
      'hi': 'मिट्टी की स्थिति और सेंसर रीडिंग के लिए सूचनाएं सक्षम करें',
      'mr': 'मातीची स्थिती आणि सेन्सर रीडिंगसाठी सूचना सक्षम करा',
      'pa': 'ਮਿੱਟੀ ਦੀਆਂ ਸਥਿਤੀਆਂ ਅਤੇ ਸੈਂਸਰ ਰੀਡਿੰਗਾਂ ਲਈ ਸੂਚਨਾਵਾਂ ਨੂੰ ਸਮਰੱਥ ਬਣਾਓ',
    },
    'pq38rjcc': {
      'en': 'Low Moisture Alert',
      'gu': 'ઓછા ભેજની ચેતવણી',
      'hi': 'कम नमी की चेतावनी',
      'mr': 'कमी आर्द्रतेचा इशारा',
      'pa': 'ਘੱਟ ਨਮੀ ਦੀ ਚੇਤਾਵਨੀ',
    },
    'f6ksv0fx': {
      'en': 'High Nutrient Alert',
      'gu': 'ઉચ્ચ પોષક તત્વોની ચેતવણી',
      'hi': 'उच्च पोषक तत्व चेतावनी',
      'mr': 'उच्च पोषक तत्वांचा इशारा',
      'pa': 'ਉੱਚ ਪੌਸ਼ਟਿਕ ਤੱਤਾਂ ਸੰਬੰਧੀ ਸੁਚੇਤਨਾ',
    },
    'pnze2jpy': {
      'en': 'pH Level Alert',
      'gu': 'pH સ્તર ચેતવણી',
      'hi': 'पीएच स्तर चेतावनी',
      'mr': 'पीएच पातळी सूचना',
      'pa': 'pH ਪੱਧਰ ਚੇਤਾਵਨੀ',
    },
    '9uz1akzl': {
      'en': 'Temperature Alert',
      'gu': 'તાપમાન ચેતવણી',
      'hi': 'तापमान चेतावनी',
      'mr': 'तापमान सूचना',
      'pa': 'ਤਾਪਮਾਨ ਚੇਤਾਵਨੀ',
    },
    'ax0borco': {
      'en': 'Sensor Malfunction Alert',
      'gu': 'સેન્સર ખામી ચેતવણી',
      'hi': 'सेंसर खराबी चेतावनी',
      'mr': 'सेन्सर खराबी सूचना',
      'pa': 'ਸੈਂਸਰ ਖਰਾਬੀ ਚੇਤਾਵਨੀ',
    },
    'yzn3w5wx': {
      'en': 'Alert Timing Settings',
      'gu': 'ચેતવણી સમય સેટિંગ્સ',
      'hi': 'अलर्ट समय सेटिंग',
      'mr': 'अलर्ट वेळेची सेटिंग्ज',
      'pa': 'ਚੇਤਾਵਨੀ ਸਮਾਂ ਸੈਟਿੰਗਾਂ',
    },
    'm4o3ak0v': {
      'en': 'Configure when and how often you receive alerts',
      'gu': 'તમને ક્યારે અને કેટલી વાર ચેતવણીઓ પ્રાપ્ત થાય છે તે ગોઠવો',
      'hi': 'कॉन्फ़िगर करें कि आपको अलर्ट कब और कितनी बार प्राप्त हों',
      'mr': 'तुम्हाला कधी आणि किती वेळा सूचना मिळतात ते कॉन्फिगर करा',
      'pa': 'ਤੁਹਾਨੂੰ ਕਦੋਂ ਅਤੇ ਕਿੰਨੀ ਵਾਰ ਅਲਰਟ ਪ੍ਰਾਪਤ ਹੁੰਦੇ ਹਨ, ਇਹ ਕੌਂਫਿਗਰ ਕਰੋ',
    },
    '2b73h2eh': {
      'en': 'Alert Time',
      'gu': 'ચેતવણી સમય',
      'hi': 'चेतावनी समय',
      'mr': 'सूचना वेळ',
      'pa': 'ਚੇਤਾਵਨੀ ਸਮਾਂ',
    },
    'l73ylsbd': {
      'en': '08:00 AM',
      'gu': 'સવારે ૮:૦૦ વાગ્યે',
      'hi': '08:00 पूर्वाह्न',
      'mr': 'सकाळी ०८:०० वा.',
      'pa': 'ਸਵੇਰੇ 08:00 ਵਜੇ',
    },
    'djh0glla': {
      'en': 'Set Alert Time',
      'gu': 'ચેતવણી સમય સેટ કરો',
      'hi': 'अलर्ट समय सेट करें',
      'mr': 'अलर्ट वेळ सेट करा',
      'pa': 'ਚੇਤਾਵਨੀ ਸਮਾਂ ਸੈੱਟ ਕਰੋ',
    },
    'hm50x1tt': {
      'en': 'Alert Frequency',
      'gu': 'ચેતવણી આવર્તન',
      'hi': 'चेतावनी आवृत्ति',
      'mr': 'अलर्ट वारंवारता',
      'pa': 'ਚੇਤਾਵਨੀ ਬਾਰੰਬਾਰਤਾ',
    },
    'jqbn53nf': {
      'en': 'Daily',
      'gu': 'દૈનિક',
      'hi': 'दैनिक',
      'mr': 'दैनंदिन',
      'pa': 'ਰੋਜ਼ਾਨਾ',
    },
    'gjiz4s82': {
      'en': 'Daily',
      'gu': 'દૈનિક',
      'hi': 'दैनिक',
      'mr': 'दैनंदिन',
      'pa': 'ਰੋਜ਼ਾਨਾ',
    },
    'apebvggw': {
      'en': 'Weekly',
      'gu': 'સાપ્તાહિક',
      'hi': 'साप्ताहिक',
      'mr': 'साप्ताहिक',
      'pa': 'ਹਫ਼ਤਾਵਾਰੀ',
    },
    'c8zwjm7o': {
      'en': 'Monthly',
      'gu': 'માસિક',
      'hi': 'महीने के',
      'mr': 'मासिक',
      'pa': 'ਮਹੀਨੇਵਾਰ',
    },
    '8l4jkzfj': {
      'en': 'Repeat Alerts',
      'gu': 'પુનરાવર્તિત ચેતવણીઓ',
      'hi': 'दोहराए गए अलर्ट',
      'mr': 'पुनरावृत्ती सूचना',
      'pa': 'ਦੁਹਰਾਓ ਚੇਤਾਵਨੀਆਂ',
    },
    'j9zwjjjk': {
      'en': 'Alert Interval',
      'gu': 'ચેતવણી અંતરાલ',
      'hi': 'चेतावनी अंतराल',
      'mr': 'सूचना मध्यांतर',
      'pa': 'ਚੇਤਾਵਨੀ ਅੰਤਰਾਲ',
    },
    'ebeynarr': {
      'en': 'Time between repeated alerts',
      'gu': 'પુનરાવર્તિત ચેતવણીઓ વચ્ચેનો સમય',
      'hi': 'बार-बार अलर्ट के बीच का समय',
      'mr': 'पुनरावृत्ती होणाऱ्या सूचनांमधील वेळ',
      'pa': 'ਦੁਹਰਾਈਆਂ ਜਾਣ ਵਾਲੀਆਂ ਚੇਤਾਵਨੀਆਂ ਵਿਚਕਾਰ ਸਮਾਂ',
    },
    'd2msg5uh': {
      'en': '30 min',
      'gu': '૩૦ મિનિટ',
      'hi': '30 मिनट',
      'mr': '३० मिनिटे',
      'pa': '30 ਮਿੰਟ',
    },
    '08npueq3': {
      'en': '5m',
      'gu': '૫ મી',
      'hi': '5 मिनट',
      'mr': '५ मी',
      'pa': '5 ਮੀ.',
    },
    '6fid986j': {
      'en': '60m',
      'gu': '૬૦ મી',
      'hi': '60 मीटर',
      'mr': '६० मी',
      'pa': '60 ਮੀ',
    },
    'sr4kzlj6': {
      'en': '120m',
      'gu': '૧૨૦ મી',
      'hi': '120मी',
      'mr': '१२० मी',
      'pa': '120 ਮੀ',
    },
    '28prvdca': {
      'en': 'Save Alert Settings',
      'gu': 'ચેતવણી સેટિંગ્સ સાચવો',
      'hi': 'अलर्ट सेटिंग सहेजें',
      'mr': 'अलर्ट सेटिंग्ज सेव्ह करा',
      'pa': 'ਚੇਤਾਵਨੀ ਸੈਟਿੰਗਾਂ ਨੂੰ ਸੁਰੱਖਿਅਤ ਕਰੋ',
    },
  },
  // analytics3
  {
    'sbuhwlpw': {
      'en': 'Analytics',
      'gu': 'વિશ્લેષણ',
      'hi': 'एनालिटिक्स',
      'mr': 'विश्लेषण',
      'pa': 'ਵਿਸ਼ਲੇਸ਼ਣ',
    },
    'vfcaq0ax': {
      'en': 'Total Scans',
      'gu': 'કુલ સ્કેન',
      'hi': 'कुल स्कैन',
      'mr': 'एकूण स्कॅन',
      'pa': 'ਕੁੱਲ ਸਕੈਨ',
    },
    'lsxt90xd': {
      'en': '255',
      'gu': '૨૫૫',
      'hi': '255',
      'mr': '२५५',
      'pa': '255',
    },
    '6wzu29n7': {
      'en': '32.2%',
      'gu': '૩૨.૨%',
      'hi': '32.2%',
      'mr': '३२.२%',
      'pa': '32.2%',
    },
    'gt1lkxaq': {
      'en': 'Monthly Scans',
      'gu': 'માસિક સ્કેન',
      'hi': 'मासिक स्कैन',
      'mr': 'मासिक स्कॅन',
      'pa': 'ਮਾਸਿਕ ਸਕੈਨ',
    },
    'luzucj35': {
      'en': '67',
      'gu': '૬૭',
      'hi': '67',
      'mr': '६७',
      'pa': '67',
    },
    'hpdmvq6a': {
      'en': '45.5%',
      'gu': '૪૫.૫%',
      'hi': '45.5%',
      'mr': '४५.५%',
      'pa': '45.5%',
    },
    'qhyrf29k': {
      'en': 'Recent Activity',
      'gu': 'તાજેતરની પ્રવૃત્તિ',
      'hi': 'हाल की गतिविधि',
      'mr': 'अलीकडील क्रियाकलाप',
      'pa': 'ਹਾਲੀਆ ਗਤੀਵਿਧੀ',
    },
    'aywz6fus': {
      'en': 'Below is an overview of tasks & activity completed.',
      'gu': 'નીચે પૂર્ણ થયેલા કાર્યો અને પ્રવૃત્તિનો ઝાંખી આપેલ છે.',
      'hi': 'नीचे पूर्ण किये गये कार्यों एवं गतिविधियों का अवलोकन दिया गया है।',
      'mr': 'खाली पूर्ण झालेल्या कार्यांचा आणि क्रियाकलापांचा आढावा दिला आहे.',
      'pa':
          'ਹੇਠਾਂ ਪੂਰੇ ਕੀਤੇ ਗਏ ਕੰਮਾਂ ਅਤੇ ਗਤੀਵਿਧੀ ਦੀ ਸੰਖੇਪ ਜਾਣਕਾਰੀ ਦਿੱਤੀ ਗਈ ਹੈ।',
    },
    '8wdrtk7e': {
      'en': 'Tasks',
      'gu': 'કાર્યો',
      'hi': 'कार्य',
      'mr': 'कार्ये',
      'pa': 'ਕੰਮ',
    },
    't8pszbdi': {
      'en': 'Completed',
      'gu': 'પૂર્ણ',
      'hi': 'पुरा होना।',
      'mr': 'पूर्ण झाले',
      'pa': 'ਪੂਰਾ ਹੋਇਆ',
    },
    'n88pruul': {
      'en': 'Soil Moisture Trends',
      'gu': 'માટી ભેજ વલણો',
      'hi': 'मृदा नमी का रुझान',
      'mr': 'मातीतील ओलावा ट्रेंड',
      'pa': 'ਮਿੱਟੀ ਦੀ ਨਮੀ ਦੇ ਰੁਝਾਨ',
    },
    'a544yrbz': {
      'en': 'Last 7 Days',
      'gu': 'છેલ્લા ૭ દિવસ',
      'hi': 'पिछले 7 दिन',
      'mr': 'शेवटचे ७ दिवस',
      'pa': 'ਪਿਛਲੇ 7 ਦਿਨ',
    },
    'oc4ejy5g': {
      'en': 'Search...',
      'gu': 'શોધો...',
      'hi': 'खोज...',
      'mr': 'शोधा...',
      'pa': 'ਖੋਜ...',
    },
    'cp2d3z49': {
      'en': 'Last 7 Days',
      'gu': 'છેલ્લા ૭ દિવસ',
      'hi': 'पिछले 7 दिन',
      'mr': 'शेवटचे ७ दिवस',
      'pa': 'ਪਿਛਲੇ 7 ਦਿਨ',
    },
    '9o72gflb': {
      'en': 'Last 30 Days',
      'gu': 'છેલ્લા ૩૦ દિવસ',
      'hi': 'पिछले 30 दिन',
      'mr': 'शेवटचे ३० दिवस',
      'pa': 'ਪਿਛਲੇ 30 ਦਿਨ',
    },
    'bxtekc5j': {
      'en': 'Last 90 Days',
      'gu': 'છેલ્લા ૯૦ દિવસ',
      'hi': 'पिछले 90 दिन',
      'mr': 'शेवटचे ९० दिवस',
      'pa': 'ਪਿਛਲੇ 90 ਦਿਨ',
    },
    'i2mh0t2r': {
      'en': 'Last 30 Days',
      'gu': 'છેલ્લા ૩૦ દિવસ',
      'hi': 'पिछले 30 दिन',
      'mr': 'शेवटचे ३० दिवस',
      'pa': 'ਪਿਛਲੇ 30 ਦਿਨ',
    },
    'wrurv3ff': {
      'en': 'Avg. Grade',
      'gu': 'સરેરાશ ગ્રેડ',
      'hi': 'औसत ग्रेड',
      'mr': 'सरासरी श्रेणी',
      'pa': 'ਔਸਤ ਗ੍ਰੇਡ',
    },
    'ct6cz53i': {
      'en': 'Current',
      'gu': 'વર્તમાન',
      'hi': 'मौजूदा',
      'mr': 'चालू',
      'pa': 'ਮੌਜੂਦਾ',
    },
    'lypbckh0': {
      'en': '32%',
      'gu': '૩૨%',
      'hi': '32%',
      'mr': '३२%',
      'pa': '32%',
    },
    'ys68qw8m': {
      'en': 'Moisture',
      'gu': 'ભેજ',
      'hi': 'नमी',
      'mr': 'ओलावा',
      'pa': 'ਨਮੀ',
    },
    'ft4kp0sn': {
      'en': 'Average',
      'gu': 'સરેરાશ',
      'hi': 'औसत',
      'mr': 'सरासरी',
      'pa': 'ਔਸਤ',
    },
    'zom379yt': {
      'en': '38%',
      'gu': '૩૮%',
      'hi': '38%',
      'mr': '३८%',
      'pa': '38%',
    },
    '5gozszq4': {
      'en': 'Last 7 days',
      'gu': 'છેલ્લા 7 દિવસ',
      'hi': 'पिछले 7 दिन',
      'mr': 'शेवटचे ७ दिवस',
      'pa': 'ਪਿਛਲੇ 7 ਦਿਨ',
    },
    '7fb47m4t': {
      'en': 'Change',
      'gu': 'બદલો',
      'hi': 'परिवर्तन',
      'mr': 'बदला',
      'pa': 'ਬਦਲੋ',
    },
    'vep65yyv': {
      'en': '15%',
      'gu': '૧૫%',
      'hi': '15%',
      'mr': '१५%',
      'pa': '15%',
    },
    'gm9h97vh': {
      'en': 'Last 24h',
      'gu': 'છેલ્લા 24 કલાક',
      'hi': 'पिछले 24 घंटे',
      'mr': 'गेल्या २४ तासांत',
      'pa': 'ਪਿਛਲੇ 24 ਘੰਟੇ',
    },
    'to82bpd1': {
      'en': 'Soil pH & Nutrients',
      'gu': 'માટીનું pH અને પોષક તત્વો',
      'hi': 'मृदा पीएच और पोषक तत्व',
      'mr': 'मातीचे सामू आणि पोषक घटक',
      'pa': 'ਮਿੱਟੀ ਦਾ pH ਅਤੇ ਪੌਸ਼ਟਿਕ ਤੱਤ',
    },
    'u23nz758': {
      'en': 'pH',
      'gu': 'પીએચ',
      'hi': 'पीएच',
      'mr': 'पीएच',
      'pa': 'ਪੀ.ਐੱਚ.',
    },
    'a3wimtcq': {
      'en': 'Nitrogen',
      'gu': 'નાઇટ્રોજન',
      'hi': 'नाइट्रोजन',
      'mr': 'नायट्रोजन',
      'pa': 'ਨਾਈਟ੍ਰੋਜਨ',
    },
    'oej4mlnz': {
      'en': 'Phosphorus',
      'gu': 'ફોસ્ફરસ',
      'hi': 'फास्फोरस',
      'mr': 'फॉस्फरस',
      'pa': 'ਫਾਸਫੋਰਸ',
    },
    '0zb02oha': {
      'en': 'Potassium',
      'gu': 'પોટેશિયમ',
      'hi': 'पोटेशियम',
      'mr': 'पोटॅशियम',
      'pa': 'ਪੋਟਾਸ਼ੀਅਮ',
    },
    'dcjyte3o': {
      'en': 'pH',
      'gu': 'પીએચ',
      'hi': 'पीएच',
      'mr': 'पीएच',
      'pa': 'ਪੀ.ਐੱਚ.',
    },
    '5zi9c7wc': {
      'en': 'Last 30 Days',
      'gu': 'છેલ્લા ૩૦ દિવસ',
      'hi': 'पिछले 30 दिन',
      'mr': 'शेवटचे ३० दिवस',
      'pa': 'ਪਿਛਲੇ 30 ਦਿਨ',
    },
    'a3jpcbtr': {
      'en': 'Avg. Grade',
      'gu': 'સરેરાશ ગ્રેડ',
      'hi': 'औसत ग्रेड',
      'mr': 'सरासरी श्रेणी',
      'pa': 'ਔਸਤ ਗ੍ਰੇਡ',
    },
    'wlllzgw8': {
      'en': 'pH Level',
      'gu': 'પીએચ સ્તર',
      'hi': 'पीएच स्तर',
      'mr': 'पीएच पातळी',
      'pa': 'pH ਪੱਧਰ',
    },
    'l6796ta0': {
      'en': '6.2',
      'gu': '૬.૨',
      'hi': '6.2',
      'mr': '६.२',
      'pa': '6.2',
    },
    '5uz6dhxg': {
      'en': 'Slightly Acidic',
      'gu': 'સહેજ એસિડિક',
      'hi': 'थोड़ा अम्लीय',
      'mr': 'किंचित आम्लयुक्त',
      'pa': 'ਥੋੜ੍ਹਾ ਜਿਹਾ ਤੇਜ਼ਾਬੀ',
    },
    'akb44rxh': {
      'en': 'Nitrogen',
      'gu': 'નાઇટ્રોજન',
      'hi': 'नाइट्रोजन',
      'mr': 'नायट्रोजन',
      'pa': 'ਨਾਈਟ੍ਰੋਜਨ',
    },
    'x9rg3wmr': {
      'en': 'Low',
      'gu': 'નીચું',
      'hi': 'कम',
      'mr': 'कमी',
      'pa': 'ਘੱਟ',
    },
    'xh3mglov': {
      'en': '42 ppm',
      'gu': '૪૨ પીપીએમ',
      'hi': '42 पीपीएम',
      'mr': '४२ पीपीएम',
      'pa': '42 ਪੀਪੀਐਮ',
    },
    'hxvjt7um': {
      'en': 'Phosphorus',
      'gu': 'ફોસ્ફરસ',
      'hi': 'फास्फोरस',
      'mr': 'फॉस्फरस',
      'pa': 'ਫਾਸਫੋਰਸ',
    },
    'ghrnxaac': {
      'en': 'Good',
      'gu': 'સારું',
      'hi': 'अच्छा',
      'mr': 'चांगले',
      'pa': 'ਚੰਗਾ',
    },
    '71alcd0v': {
      'en': '28 ppm',
      'gu': '૨૮ પીપીએમ',
      'hi': '28 पीपीएम',
      'mr': '२८ पीपीएम',
      'pa': '28 ਪੀਪੀਐਮ',
    },
    'j088io5g': {
      'en': 'Tasks',
      'gu': 'કાર્યો',
      'hi': 'कार्य',
      'mr': 'कार्ये',
      'pa': 'ਕੰਮ',
    },
    'g5lock4o': {
      'en': 'A summary of outstanding tasks.',
      'gu': 'બાકી રહેલા કાર્યોનો સારાંશ.',
      'hi': 'बकाया कार्यों का सारांश.',
      'mr': 'उत्कृष्ट कामांचा सारांश.',
      'pa': 'ਬਕਾਇਆ ਕੰਮਾਂ ਦਾ ਸਾਰ।',
    },
    'kwcgvbgs': {
      'en': 'Task Type',
      'gu': 'કાર્ય પ્રકાર',
      'hi': 'कार्य प्रकार',
      'mr': 'कार्य प्रकार',
      'pa': 'ਕਾਰਜ ਕਿਸਮ',
    },
    'baeynshi': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'gu':
          'અહીં કાર્યનું વર્ણન આ ખરેખર લાંબું છે અને કદાચ તે વધુ ચાલે છે? અને બે લીટીઓ સુધી જાય છે.',
      'hi':
          'कार्य विवरण यहाँ यह वास्तव में लंबा है और यह शायद खत्म हो जाता है? और दो पंक्तियों तक जाता है।',
      'mr':
          'येथे कार्य वर्णन हे खूप लांब आहे आणि कदाचित ते जास्त आहे? आणि दोन ओळींपर्यंत जाते.',
      'pa':
          'ਇੱਥੇ ਕੰਮ ਦਾ ਵੇਰਵਾ ਇਹ ਸੱਚਮੁੱਚ ਲੰਮਾ ਹੈ ਅਤੇ ਇਹ ਸ਼ਾਇਦ ਵੱਧ ਜਾਂਦਾ ਹੈ? ਅਤੇ ਦੋ ਲਾਈਨਾਂ ਤੱਕ ਜਾਂਦਾ ਹੈ।',
    },
    'zmmeuj44': {
      'en': 'Due',
      'gu': 'બાકી',
      'hi': 'देय',
      'mr': 'देय',
      'pa': 'ਬਕਾਇਆ',
    },
    '9pnzy8r1': {
      'en': 'Today, 5:30pm',
      'gu': 'આજે, સાંજે ૫:૩૦ વાગ્યે',
      'hi': 'आज, शाम 5:30 बजे',
      'mr': 'आज, संध्याकाळी ५:३० वाजता',
      'pa': 'ਅੱਜ, ਸ਼ਾਮ 5:30 ਵਜੇ',
    },
    'sjtk8wdg': {
      'en': 'Update',
      'gu': 'અપડેટ',
      'hi': 'अद्यतन',
      'mr': 'अपडेट करा',
      'pa': 'ਅੱਪਡੇਟ',
    },
    '4bmkjrr9': {
      'en': '1',
      'gu': '૧',
      'hi': '1',
      'mr': '१',
      'pa': '1',
    },
    'jfw1phcn': {
      'en': 'Task Type',
      'gu': 'કાર્ય પ્રકાર',
      'hi': 'कार्य प्रकार',
      'mr': 'कार्य प्रकार',
      'pa': 'ਕਾਰਜ ਕਿਸਮ',
    },
    '4zkfg276': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'gu':
          'અહીં કાર્યનું વર્ણન આ ખરેખર લાંબું છે અને કદાચ તે વધુ ચાલે છે? અને બે લીટીઓ સુધી જાય છે.',
      'hi':
          'कार्य विवरण यहाँ यह वास्तव में लंबा है और यह शायद खत्म हो जाता है? और दो पंक्तियों तक जाता है।',
      'mr':
          'येथे कार्य वर्णन हे खूप लांब आहे आणि कदाचित ते जास्त आहे? आणि दोन ओळींपर्यंत जाते.',
      'pa':
          'ਇੱਥੇ ਕੰਮ ਦਾ ਵੇਰਵਾ ਇਹ ਸੱਚਮੁੱਚ ਲੰਮਾ ਹੈ ਅਤੇ ਇਹ ਸ਼ਾਇਦ ਵੱਧ ਜਾਂਦਾ ਹੈ? ਅਤੇ ਦੋ ਲਾਈਨਾਂ ਤੱਕ ਜਾਂਦਾ ਹੈ।',
    },
    'nlv1ppgu': {
      'en': 'Due',
      'gu': 'બાકી',
      'hi': 'देय',
      'mr': 'देय',
      'pa': 'ਬਕਾਇਆ',
    },
    '81kkekqp': {
      'en': 'Today, 5:30pm',
      'gu': 'આજે, સાંજે ૫:૩૦ વાગ્યે',
      'hi': 'आज, शाम 5:30 बजे',
      'mr': 'आज, संध्याकाळी ५:३० वाजता',
      'pa': 'ਅੱਜ, ਸ਼ਾਮ 5:30 ਵਜੇ',
    },
    'kp7cxr99': {
      'en': 'Update',
      'gu': 'અપડેટ',
      'hi': 'अद्यतन',
      'mr': 'अपडेट करा',
      'pa': 'ਅੱਪਡੇਟ',
    },
    'wki2398y': {
      'en': '1',
      'gu': '૧',
      'hi': '1',
      'mr': '१',
      'pa': '1',
    },
    'emw9maai': {
      'en': 'Alerts & Insights',
      'gu': 'ચેતવણીઓ અને આંતરદૃષ્ટિ',
      'hi': 'अलर्ट और अंतर्दृष्टि',
      'mr': 'सूचना आणि अंतर्दृष्टी',
      'pa': 'ਚੇਤਾਵਨੀਆਂ ਅਤੇ ਸੂਝ-ਬੂਝ',
    },
    'detpns17': {
      'en': 'Moisture Alert',
      'gu': 'ભેજ ચેતવણી',
      'hi': 'नमी चेतावनी',
      'mr': 'ओलावा इशारा',
      'pa': 'ਨਮੀ ਸੰਬੰਧੀ ਚੇਤਾਵਨੀ',
    },
    'kx5ghd94': {
      'en':
          'Soil moisture has dropped 15% in the last 24 hours. Consider irrigation soon.',
      'gu':
          'છેલ્લા ૨૪ કલાકમાં જમીનની ભેજ ૧૫% ઘટી ગઈ છે. જલ્દી સિંચાઈ કરવાનું વિચારો.',
      'hi':
          'पिछले 24 घंटों में मिट्टी की नमी में 15% की गिरावट आई है। जल्द ही सिंचाई पर विचार करें।',
      'mr':
          'गेल्या २४ तासांत जमिनीतील ओलावा १५% कमी झाला आहे. लवकरच सिंचनाचा विचार करा.',
      'pa':
          'ਪਿਛਲੇ 24 ਘੰਟਿਆਂ ਵਿੱਚ ਮਿੱਟੀ ਦੀ ਨਮੀ 15% ਘੱਟ ਗਈ ਹੈ। ਜਲਦੀ ਹੀ ਸਿੰਚਾਈ ਬਾਰੇ ਵਿਚਾਰ ਕਰੋ।',
    },
    'el70o69r': {
      'en': 'Nutrient Insight',
      'gu': 'પોષક તત્વોની સમજ',
      'hi': 'पोषक तत्व अंतर्दृष्टि',
      'mr': 'पोषक तत्वांचा आढावा',
      'pa': 'ਪੌਸ਼ਟਿਕ ਤੱਤਾਂ ਦੀ ਸੂਝ',
    },
    'wsycseb9': {
      'en':
          'Nitrogen levels indicate possible deficiency. Consider applying nitrogen-rich fertilizer.',
      'gu':
          'નાઇટ્રોજનનું સ્તર શક્ય ઉણપ દર્શાવે છે. નાઇટ્રોજનયુક્ત ખાતરનો ઉપયોગ કરવાનું વિચારો.',
      'hi':
          'नाइट्रोजन का स्तर संभावित कमी का संकेत देता है। नाइट्रोजन युक्त उर्वरक लगाने पर विचार करें।',
      'mr':
          'नायट्रोजनचे प्रमाण संभाव्य कमतरता दर्शवते. नायट्रोजनयुक्त खतांचा वापर करण्याचा विचार करा.',
      'pa':
          'ਨਾਈਟ੍ਰੋਜਨ ਦੇ ਪੱਧਰ ਸੰਭਾਵੀ ਘਾਟ ਨੂੰ ਦਰਸਾਉਂਦੇ ਹਨ। ਨਾਈਟ੍ਰੋਜਨ ਨਾਲ ਭਰਪੂਰ ਖਾਦ ਪਾਉਣ ਬਾਰੇ ਵਿਚਾਰ ਕਰੋ।',
    },
    'sabr0w8w': {
      'en': 'Optimal Condition',
      'gu': 'શ્રેષ્ઠ સ્થિતિ',
      'hi': 'इष्टतम स्थिति',
      'mr': 'इष्टतम स्थिती',
      'pa': 'ਅਨੁਕੂਲ ਸਥਿਤੀ',
    },
    '11x0tj55': {
      'en':
          'Phosphorus and Potassium levels are within optimal range for plant growth.',
      'gu':
          'છોડના વિકાસ માટે ફોસ્ફરસ અને પોટેશિયમનું સ્તર શ્રેષ્ઠ મર્યાદામાં છે.',
      'hi':
          'फास्फोरस और पोटेशियम का स्तर पौधों की वृद्धि के लिए इष्टतम सीमा के भीतर है।',
      'mr':
          'वनस्पतींच्या वाढीसाठी फॉस्फरस आणि पोटॅशियमचे प्रमाण इष्टतम मर्यादेत असते.',
      'pa':
          'ਫਾਸਫੋਰਸ ਅਤੇ ਪੋਟਾਸ਼ੀਅਮ ਦੇ ਪੱਧਰ ਪੌਦਿਆਂ ਦੇ ਵਾਧੇ ਲਈ ਅਨੁਕੂਲ ਸੀਮਾ ਦੇ ਅੰਦਰ ਹਨ।',
    },
    'odxj6zr9': {
      'en': 'Comparative Analysis',
      'gu': 'તુલનાત્મક વિશ્લેષણ',
      'hi': 'तुलनात्मक विश्लेषण',
      'mr': 'तुलनात्मक विश्लेषण',
      'pa': 'ਤੁਲਨਾਤਮਕ ਵਿਸ਼ਲੇਸ਼ਣ',
    },
    'r5ylrtzd': {
      'en': 'Export as PDF',
      'gu': 'PDF તરીકે નિકાસ કરો',
      'hi': 'पीडीएफ के रूप में निर्यात करें',
      'mr': 'PDF म्हणून निर्यात करा',
      'pa': 'PDF ਦੇ ਤੌਰ \'ਤੇ ਨਿਰਯਾਤ ਕਰੋ',
    },
    '50co06d6': {
      'en': 'Export as CSV',
      'gu': 'CSV તરીકે નિકાસ કરો',
      'hi': 'CSV के रूप में निर्यात करें',
      'mr': 'CSV म्हणून निर्यात करा',
      'pa': 'CSV ਵਜੋਂ ਨਿਰਯਾਤ ਕਰੋ',
    },
    'pbg366ir': {
      'en': 'Analytics',
      'gu': 'વિશ્લેષણ',
      'hi': 'एनालिटिक्स',
      'mr': 'विश्लेषण',
      'pa': 'ਵਿਸ਼ਲੇਸ਼ਣ',
    },
  },
  // Dropdown01Options
  {
    'dfatco0w': {
      'en': 'Options',
      'gu': 'વિકલ્પો',
      'hi': 'विकल्प',
      'mr': 'पर्याय',
      'pa': 'ਵਿਕਲਪ',
    },
    '0pm6qay3': {
      'en': 'Upload Image',
      'gu': 'છબી અપલોડ કરો',
      'hi': 'तस्विर अपलोड करना',
      'mr': 'प्रतिमा अपलोड करा',
      'pa': 'ਚਿੱਤਰ ਅੱਪਲੋਡ ਕਰੋ',
    },
    '7jyfda9n': {
      'en': 'Open Camera',
      'gu': 'કૅમેરો ખોલો',
      'hi': 'कैमरा खोलें',
      'mr': 'कॅमेरा उघडा',
      'pa': 'ਕੈਮਰਾ ਖੋਲ੍ਹੋ',
    },
    'y4gd938o': {
      'en': 'Upload File',
      'gu': 'ફાઇલ અપલોડ કરો',
      'hi': 'फ़ाइल अपलोड करें',
      'mr': 'फाइल अपलोड करा',
      'pa': 'ਫਾਈਲ ਅਪਲੋਡ ਕਰੋ',
    },
    '1y33jbre': {
      'en': 'Save as Theme Style',
      'gu': 'થીમ શૈલી તરીકે સાચવો',
      'hi': 'थीम शैली के रूप में सहेजें',
      'mr': 'थीम शैली म्हणून जतन करा',
      'pa': 'ਥੀਮ ਸਟਾਈਲ ਵਜੋਂ ਸੇਵ ਕਰੋ',
    },
  },
  // aiBottomSheet
  {
    'poiwhbx8': {
      'en': 'Upload to Krishi AI',
      'gu': 'કૃષિ એઆઈ પર અપલોડ કરો',
      'hi': 'कृषि एआई पर अपलोड करें',
      'mr': 'कृषी एआय वर अपलोड करा',
      'pa': 'ਕ੍ਰਿਸ਼ੀ ਏਆਈ \'ਤੇ ਅਪਲੋਡ ਕਰੋ',
    },
    '8eawddfq': {
      'en': 'Camera',
      'gu': 'કેમેરા',
      'hi': 'कैमरा',
      'mr': 'कॅमेरा',
      'pa': 'ਕੈਮਰਾ',
    },
    'wkzuqjs7': {
      'en': 'Photos',
      'gu': 'ફોટા',
      'hi': 'तस्वीरें',
      'mr': 'फोटो',
      'pa': 'ਫੋਟੋਆਂ',
    },
    'dipu0cos': {
      'en': 'Files',
      'gu': 'ફાઇલો',
      'hi': 'फ़ाइलें',
      'mr': 'फायली',
      'pa': 'ਫਾਈਲਾਂ',
    },
  },
  // sensorData
  {
    'odzmntrm': {
      'en': 'Sensor Data',
      'gu': 'સેન્સર ડેટા',
      'hi': 'सेंसर डेटा',
      'mr': 'सेन्सर डेटा',
      'pa': 'ਸੈਂਸਰ ਡਾਟਾ',
    },
    '6dffx9u8': {
      'en': 'Nitrogen (N)',
      'gu': 'નાઇટ્રોજન (N)',
      'hi': 'नाइट्रोजन (एन)',
      'mr': 'नायट्रोजन (N)',
      'pa': 'ਨਾਈਟ੍ਰੋਜਨ (N)',
    },
    'sx6kzes0': {
      'en': 'Phosphorus (P)',
      'gu': 'ફોસ્ફરસ (P)',
      'hi': 'फास्फोरस (P)',
      'mr': 'फॉस्फरस (P)',
      'pa': 'ਫਾਸਫੋਰਸ (P)',
    },
    '2h8arile': {
      'en': 'Potassium (K)',
      'gu': 'પોટેશિયમ (K)',
      'hi': 'पोटेशियम (K)',
      'mr': 'पोटॅशियम (के)',
      'pa': 'ਪੋਟਾਸ਼ੀਅਮ (K)',
    },
    'q29l1hkk': {
      'en': 'Electrical Conductivity',
      'gu': 'વિદ્યુત વાહકતા',
      'hi': 'इलेक्ट्रिकल कंडक्टीविटी',
      'mr': 'विद्युत चालकता',
      'pa': 'ਬਿਜਲੀ ਚਾਲਕਤਾ',
    },
    'uslop6hv': {
      'en': 'Soil Moisture',
      'gu': 'માટીનો ભેજ',
      'hi': 'मिट्टी की नमी',
      'mr': 'मातीचा ओलावा',
      'pa': 'ਮਿੱਟੀ ਦੀ ਨਮੀ',
    },
  },
  // Miscellaneous
  {
    '1npda0bd': {
      'en':
          'In order to search nearby, this app requires access to your current location.',
      'gu':
          'નજીકમાં શોધવા માટે, આ એપ્લિકેશનને તમારા વર્તમાન સ્થાનની ઍક્સેસની જરૂર છે.',
      'hi':
          'आस-पास खोज करने के लिए, इस ऐप को आपके वर्तमान स्थान तक पहुंच की आवश्यकता होती है।',
      'mr':
          'जवळपास शोधण्यासाठी, या अ‍ॅपला तुमच्या सध्याच्या स्थानाचा अ‍ॅक्सेस आवश्यक आहे.',
      'pa':
          'ਨੇੜੇ-ਤੇੜੇ ਖੋਜ ਕਰਨ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਤੁਹਾਡੇ ਮੌਜੂਦਾ ਟਿਕਾਣੇ ਤੱਕ ਪਹੁੰਚ ਦੀ ਲੋੜ ਹੈ।',
    },
    'g4ydjijd': {
      'en':
          'Vn order to capture images, this app requires permission to access the camera.',
      'gu':
          'છબીઓ કેપ્ચર કરવા માટે, આ એપ્લિકેશનને કેમેરાને ઍક્સેસ કરવાની પરવાનગીની જરૂર છે.',
      'hi':
          'छवियों को कैप्चर करने के लिए, इस ऐप को कैमरे तक पहुंचने की अनुमति की आवश्यकता होती है।',
      'mr':
          'प्रतिमा कॅप्चर करण्यासाठी, या अॅपला कॅमेरा अॅक्सेस करण्याची परवानगी आवश्यक आहे.',
      'pa':
          'ਤਸਵੀਰਾਂ ਕੈਪਚਰ ਕਰਨ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਕੈਮਰੇ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੁੰਦੀ ਹੈ।',
    },
    'tezwfmmu': {
      'en':
          'Vn order to upload data, this app requires permission to access the photo library.',
      'gu':
          'ડેટા અપલોડ કરવા માટે, આ એપ્લિકેશનને ફોટો લાઇબ્રેરીને ઍક્સેસ કરવાની પરવાનગીની જરૂર છે.',
      'hi':
          'डेटा अपलोड करने के लिए, इस ऐप को फोटो लाइब्रेरी तक पहुंचने की अनुमति की आवश्यकता होती है।',
      'mr':
          'डेटा अपलोड करण्यासाठी, या अॅपला फोटो लायब्ररीमध्ये प्रवेश करण्याची परवानगी आवश्यक आहे.',
      'pa':
          'ਡਾਟਾ ਅਪਲੋਡ ਕਰਨ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਫੋਟੋ ਲਾਇਬ੍ਰੇਰੀ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੁੰਦੀ ਹੈ।',
    },
    '4vz1r01d': {
      'en': 'Allow app to display notifications.',
      'gu': 'એપ્લિકેશનને સૂચનાઓ પ્રદર્શિત કરવાની મંજૂરી આપો.',
      'hi': 'एप्लिकेशन को सूचनाएं प्रदर्शित करने की अनुमति दें.',
      'mr': 'अ‍ॅपला सूचना प्रदर्शित करण्याची परवानगी द्या.',
      'pa': 'ਐਪ ਨੂੰ ਸੂਚਨਾਵਾਂ ਦਿਖਾਉਣ ਦੀ ਆਗਿਆ ਦਿਓ।',
    },
    '9g35kqgs': {
      'en': 'Allows for accurate weather report catered for your loc',
      'gu': 'તમારા સ્થાન માટે સચોટ હવામાન અહેવાલ મેળવવાની મંજૂરી આપે છે',
      'hi': 'आपके स्थान के लिए सटीक मौसम रिपोर्ट की अनुमति देता है',
      'mr': 'तुमच्या स्थानासाठी अचूक हवामान अहवाल देण्याची परवानगी देते',
      'pa': 'ਤੁਹਾਡੇ ਸਥਾਨ ਲਈ ਤਿਆਰ ਕੀਤੀ ਗਈ ਸਹੀ ਮੌਸਮ ਰਿਪੋਰਟ ਦੀ ਆਗਿਆ ਦਿੰਦਾ ਹੈ',
    },
    'ocs77axy': {
      'en':
          'In order to fetch sensor data, this app requires permission to access the bluetooth.',
      'gu':
          'સેન્સર ડેટા મેળવવા માટે, આ એપ્લિકેશનને બ્લૂટૂથ ઍક્સેસ કરવાની પરવાનગીની જરૂર છે.',
      'hi':
          'सेंसर डेटा प्राप्त करने के लिए, इस ऐप को ब्लूटूथ तक पहुंच की अनुमति की आवश्यकता होती है।',
      'mr':
          'सेन्सर डेटा मिळवण्यासाठी, या अॅपला ब्लूटूथ अॅक्सेस करण्याची परवानगी आवश्यक आहे.',
      'pa':
          'ਸੈਂਸਰ ਡੇਟਾ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਬਲੂਟੁੱਥ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੈ।',
    },
    'cl0tjdr5': {
      'en':
          'In order to fetch speech responses, this app requires permission to access the microphone.',
      'gu':
          'વાણી પ્રતિભાવો મેળવવા માટે, આ એપ્લિકેશનને માઇક્રોફોન ઍક્સેસ કરવાની પરવાનગીની જરૂર છે.',
      'hi':
          'वाक् प्रत्युत्तर प्राप्त करने के लिए, इस ऐप को माइक्रोफ़ोन तक पहुंच की अनुमति की आवश्यकता होती है।',
      'mr':
          'भाषण प्रतिसाद मिळवण्यासाठी, या अ‍ॅपला मायक्रोफोन अ‍ॅक्सेस करण्याची परवानगी आवश्यक आहे.',
      'pa':
          'ਬੋਲੀ ਦੇ ਜਵਾਬ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਮਾਈਕ੍ਰੋਫ਼ੋਨ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੁੰਦੀ ਹੈ।',
    },
    'emluivcw': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'r2iaebuj': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'pp5rqzv7': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '0wtnqafj': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'j5qghfla': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'iyl8z5h6': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '876m5w9b': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'zfx43zox': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'wtgn0jyf': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '5xpsbzr1': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'h3uo4md7': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'mi6svqmb': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'wcfbl029': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'fhkfce3i': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '91we66j7': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'co3yuh1d': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '2sflcevs': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'fs6grbd9': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'f5rm1ymu': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'w40aahl9': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    '66xlrj29': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'rla7quze': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'u7zepzpm': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'pzir3d99': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
    'hwy6f9w4': {
      'en': '',
      'gu': '',
      'hi': '',
      'mr': '',
      'pa': '',
    },
  },
].reduce((a, b) => a..addAll(b));
