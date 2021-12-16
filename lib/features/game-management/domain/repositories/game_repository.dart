abstract class GameRepository {
  Map<String, String>? getCurrentGame();
  void saveGame(Map<String, String> game);
  void resetGame();
}
