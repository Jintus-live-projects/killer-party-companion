import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/end_game.dart';
import 'package:mockito/mockito.dart';

import '../repositories/game_repository_test.mocks.dart';

void main() {
  late EndGame usecase;
  late MockGameRepository repository;

  setUp(() {
    repository = MockGameRepository();
    usecase = EndGame(repository: repository);
  });

  test('should call GameRepository.resetGame', () {
    usecase();
    verify(repository.resetGame());
  });
}
