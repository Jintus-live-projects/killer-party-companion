import '../repositories/game_repository.dart';

class ProcessPlayersTargets {
  final GameRepository repository;

  const ProcessPlayersTargets({required this.repository});

  Map<String, String> call(List<String> players) {
    Map<String, String> game = {};
    players.shuffle();
    for (int i = 0; i < players.length; i++) {
      game[players[i]] = players[(i + 1) % players.length];
    }
    repository.saveGame(game);
    return game;
  }
}
