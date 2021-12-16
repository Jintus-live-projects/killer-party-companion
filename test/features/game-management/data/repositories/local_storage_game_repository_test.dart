import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/data/datasources/local_storage_datasource.dart';
import 'package:killer_party_companion/features/game-management/data/repositories/local_storage_game_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_storage_game_repository_test.mocks.dart';

@GenerateMocks([GameLocalDatasource])
void main() {
  late LocalStorageGameRepository repository;
  late MockGameLocalDatasource datasource;

  setUp(() {
    datasource = MockGameLocalDatasource();
    repository = LocalStorageGameRepository(datasource: datasource);
  });

  group('getCurrentGame', () {
    test('should call GameLocalDatasource.retrieveGame', () {
      when(datasource.retrieveGame()).thenReturn({});
      repository.getCurrentGame();
      verify(datasource.retrieveGame());
    });

    test('should return game object if no error', () {
      Map<String, String> response = {};
      when(datasource.retrieveGame()).thenReturn(response);
      Map<String, String>? result = repository.getCurrentGame();
      expect(result, response);
    });

    test('should return error if error', () {
      when(datasource.retrieveGame()).thenReturn(null);
      Map<String, String>? result = repository.getCurrentGame();
      expect(result, isNull);
    });
  });

  group('saveGame', () {
    Map<String, String> tGame = {};
    test('should call GameLocalDatasource.saveGame', () {
      repository.saveGame(tGame);
      verify(datasource.cacheGame(tGame));
    });
  });

  group('resetGame', () {
    test('should call GameLocalDatasource.resetGame', () {
      repository.resetGame();
      verify(datasource.resetGame());
    });
  });
}
