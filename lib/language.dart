import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Languages{

  Locale local;

  Languages(this.local);

  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  Map<String , String> _localizer;

  Future load() async {
    String jsonString = await rootBundle.loadString('Language/${local.languageCode}.json');

    Map<String , dynamic> mapjson = json.decode(jsonString);

    _localizer = mapjson.map((key, value) => MapEntry(key , value.toString()));
  }

  String getLocal (String key){

    return _localizer[key];
  }

  static const LocalizationsDelegate<Languages> delegate = localizationDlegate();

}

class localizationDlegate extends LocalizationsDelegate<Languages>{

  const localizationDlegate();
  @override
  bool isSupported(Locale locale) {
    return ['en' , 'ar'].contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) async {
    Languages localizer = new Languages(locale);
    await localizer.load();
    return localizer;
  }

  @override
  bool shouldReload(localizationDlegate old) => false;

}