import '../repositories/game_repository.dart';

class ResumeGame {
  final GameRepository repository;

  const ResumeGame({required this.repository});

  Map<String, String>? call() {
    return repository.getCurrentGame();
  }
}
