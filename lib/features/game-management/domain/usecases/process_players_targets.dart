import '../repositories/game_repository.dart';

class ProcessPlayersTargets {
  final GameRepository repository;

  const ProcessPlayersTargets({required this.repository});

  Map<String, String> call(List<String> players) {
    throw UnimplementedError();
  }
}
