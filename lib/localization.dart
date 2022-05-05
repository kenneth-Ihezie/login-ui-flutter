/*
This class create the foundation for multi languages
 */
import 'package:flutter/cupertino.dart';

class FlutterBlockLocalizations{
  static FlutterBlockLocalizations of(BuildContext context){
    return Localizations.of(
        context,
        FlutterBlockLocalizations
    );
  }
  String get appTitle => "LoginUi";
}

class FlutterBlockLocalizationsDelegate extends LocalizationsDelegate<FlutterBlockLocalizations> {
  @override
  bool isSupported(Locale locale) {
    locale.languageCode.toLowerCase().contains("en");
  }

  @override
  Future<FlutterBlockLocalizations> load(Locale locale) => Future(() => FlutterBlockLocalizations());

  @override
  bool shouldReload(covariant LocalizationsDelegate<FlutterBlockLocalizations> old) => false;

}