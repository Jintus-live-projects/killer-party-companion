import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class GameLocalDatasource {
  Future<void> cacheGame(Map<String, String> game);
  Future<void> resetGame();
  Map<String, String>? retrieveGame();
}

const localStorageKey = 'game';

class GameLocalDatasourceImpl implements GameLocalDatasource {
  final SharedPreferences sharedPreferences;

  GameLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheGame(Map<String, String> game) async {
    await sharedPreferences.setString(localStorageKey, jsonEncode(game));
  }

  @override
  Map<String, String>? retrieveGame() {
    String? stringifyGame = sharedPreferences.getString(localStorageKey);
    if (stringifyGame != null) {
      return Map<String, String>.from(jsonDecode(stringifyGame));
    }
    return null;
  }

  @override
  Future<void> resetGame() async {
    await sharedPreferences.remove(localStorageKey);
  }
}
