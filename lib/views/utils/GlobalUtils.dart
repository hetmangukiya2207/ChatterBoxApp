import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SetPrefrence() async {
    final SharedPreferences preferences = await _prefs;
    preferences.setBool('IsIntroVisited', true);
  }

  Future<bool?> GetPrefrence() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getBool('IsIntroVisited');
  }
}
