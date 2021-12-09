abstract class GameLocalDatasource {
  void cacheGame(Map<String, String> game);
  Map<String, String> retrieveGame();
}

class GameLocalDatasourceImpl implements GameLocalDatasource {
  @override
  void cacheGame(Map<String, String> game) {
    throw UnimplementedError();
  }

  @override
  Map<String, String> retrieveGame() {
    throw UnimplementedError();
  }
}
