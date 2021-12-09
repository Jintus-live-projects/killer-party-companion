import '../repositories/game_repository.dart';

class EndGame {
  final GameRepository repository;

  const EndGame({required this.repository});

  void call() {
    throw UnimplementedError();
  }
}
