import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/data/datasources/local_storage_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late GameLocalDatasource datasource;
  late MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    datasource = GameLocalDatasourceImpl(sharedPreferences: sharedPreferences);
  });

  group('cacheGame', () {
    Map<String, String> tGame = {};

    test('should call SharedPreferences.set', () async {
      when(sharedPreferences.setString(any, any))
          .thenAnswer((_) => Future.value(true));
      await datasource.cacheGame(tGame);
      verify(sharedPreferences.setString(localStorageKey, jsonEncode(tGame)));
    });
  });

  group('retrieveGame', () {
    Map<String, String> tGame = {};

    test('should call SharedPreferences.get', () {
      when(sharedPreferences.getString(any)).thenReturn('{}');
      datasource.retrieveGame();
      verify(sharedPreferences.getString(localStorageKey));
    });

    test('should return null if no value stored', () {
      when(sharedPreferences.getString(any)).thenReturn(null);
      Map<String, String>? result = datasource.retrieveGame();
      expect(result, isNull);
    });

    test('should return stored value', () {
      when(sharedPreferences.getString(any)).thenReturn(jsonEncode(tGame));
      Map<String, String>? result = datasource.retrieveGame();
      expect(result, tGame);
    });
  });

  group('resetGame', () {
    test('should call SharedPreferences.remove', () {
      when(sharedPreferences.remove(any)).thenAnswer((_) => Future.value(true));
      datasource.resetGame();
      verify(sharedPreferences.remove(localStorageKey));
    });
  });
}
