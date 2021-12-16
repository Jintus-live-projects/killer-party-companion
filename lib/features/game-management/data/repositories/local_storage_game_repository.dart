import '../../domain/repositories/game_repository.dart';
import '../datasources/local_storage_datasource.dart';

class LocalStorageGameRepository implements GameRepository {
  final GameLocalDatasource datasource;

  LocalStorageGameRepository({required this.datasource});

  @override
  Map<String, String>? getCurrentGame() {
    return datasource.retrieveGame();
  }

  @override
  void saveGame(Map<String, String> game) {
    datasource.cacheGame(game);
  }

  @override
  void resetGame() {
    datasource.resetGame();
  }
}
