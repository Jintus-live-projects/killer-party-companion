import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/process_players_targets.dart';
import 'package:mockito/mockito.dart';

import '../repositories/game_repository_test.mocks.dart';

void main() {
  late ProcessPlayersTargets usecase;
  late MockGameRepository repository;

  setUp(() {
    repository = MockGameRepository();
    usecase = ProcessPlayersTargets(repository: repository);
  });

  List<String> tPlayers = [
    'tPlayer1',
    'tPlayer2',
    'tPlayer3',
    'tPlayer4',
    'tPlayer5'
  ];

  test('should call GameRepository.saveGame', () {
    usecase(tPlayers);
    verify(repository.saveGame(any));
  });

  test('should return a map with the same size as the player list', () {
    Map<String, String> result = usecase(tPlayers);
    expect(result, isMap);
    expect(result.length, tPlayers.length);
  });

  test('no players should kill themselves', () {
    Map<String, String> result = usecase(tPlayers);
    expect(result.entries.every((element) => element.key != element.value),
        isTrue);
  });

  test('no players should be killed by is target (if more than 2 players)', () {
    Map<String, String> result = usecase(tPlayers);
    expect(
        result.entries.every((element) => element.key != result[element.value]),
        isTrue);
  });
}
