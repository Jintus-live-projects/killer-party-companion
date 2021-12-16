import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/resume_game.dart';
import 'package:mockito/mockito.dart';

import '../repositories/game_repository_test.mocks.dart';

void main() {
  late ResumeGame usecase;
  late MockGameRepository repository;

  setUp(() {
    repository = MockGameRepository();
    usecase = ResumeGame(repository: repository);
  });

  test('should call GameRepository.getCurrentGame', () {
    when(repository.getCurrentGame()).thenReturn({});
    usecase();
    verify(repository.getCurrentGame());
  });

  test('should return GameRepository.getCurrentGame result if no error', () {
    Map<String, String> response = {};
    when(repository.getCurrentGame()).thenReturn(response);

    Map<String, String>? result = usecase();

    expect(result, response);
  });

  test('should return GameRepository.getCurrentGame result if error occurred',
      () {
    when(repository.getCurrentGame()).thenReturn(null);

    Map<String, String>? result = usecase();

    expect(result, isNull);
  });
}
