import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/end_game.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/process_players_targets.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/resume_game.dart';
import 'package:killer_party_companion/features/game-management/presentations/blocs/game_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'game_bloc_test.mocks.dart';

@GenerateMocks([ResumeGame, ProcessPlayersTargets, EndGame])
void main() {
  late GameBloc gameBloc;
  late ResumeGame resumeGameUsecase;
  late MockProcessPlayersTargets processPlayersTargetsUsecase;
  late EndGame endGameUsecase;

  setUp(() {
    resumeGameUsecase = MockResumeGame();
    processPlayersTargetsUsecase = MockProcessPlayersTargets();
    endGameUsecase = MockEndGame();
    gameBloc = GameBloc(
        resumeGameUsecase: resumeGameUsecase,
        processPlayersTargetsUsecase: processPlayersTargetsUsecase,
        endGameUsecase: endGameUsecase);
  });

  test('initialState should be InitialState', () {
    expect(gameBloc.state, InitialState());
  });

  group('ResumeGameEvent', () {
    Map<String, String> tGame = {
      'tPlayer1': 'tPlayer3',
      'tPlayer2': 'tPlayer1',
      'tPlayer3': 'tPlayer2'
    };

    blocTest<GameBloc, GameState>('should call ResumeGame()', build: () {
      when(resumeGameUsecase()).thenReturn(null);
      return gameBloc;
    }, act: (bloc) {
      bloc.add(const ResumeGameEvent());
    }, verify: (_) {
      verify(resumeGameUsecase());
    });

    blocTest<GameBloc, GameState>('should emit [GameInfoState]',
        build: () {
          when(resumeGameUsecase()).thenReturn(tGame);
          return gameBloc;
        },
        act: (bloc) {
          bloc.add(const ResumeGameEvent());
        },
        expect: () => [isA<GameInfoState>()]);

    blocTest<GameBloc, GameState>(
      'should emit [ConfigurationState]',
      build: () {
        when(resumeGameUsecase()).thenReturn(null);
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const ResumeGameEvent());
      },
      expect: () => [const ConfigurationState(players: [])],
    );
  });

  group('AddPlayerEvent', () {
    String playerToAdd = 'tPlayer';
    blocTest<GameBloc, GameState>(
        'should not emit anything if we are not in the ConfigurationState',
        build: () {
          return gameBloc;
        },
        act: (bloc) {
          bloc.add(AddPlayerEvent(player: playerToAdd));
        },
        expect: () => []);

    blocTest<GameBloc, GameState>(
        'should add player to the player array in ConfigurationState',
        build: () {
          gameBloc.emit(const ConfigurationState(players: []));
          return gameBloc;
        },
        act: (bloc) {
          bloc.add(AddPlayerEvent(player: playerToAdd));
        },
        expect: () => [
              LoadingState(),
              ConfigurationState(players: [playerToAdd])
            ]);

    blocTest<GameBloc, GameState>(
      'should not add player if already exist',
      build: () {
        gameBloc.emit(ConfigurationState(players: [playerToAdd]));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(AddPlayerEvent(player: playerToAdd));
      },
      expect: () => [
        LoadingState(),
        ConfigurationState(players: [playerToAdd])
      ],
    );
  });

  group('RemovePlayerEvent', () {
    String playerToRemove = 'tPlayer';
    blocTest<GameBloc, GameState>(
      'should not emit anything if we are not in the ConfigurationState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(RemovePlayerEvent(player: playerToRemove));
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should remove player to the player array if exist',
      build: () {
        gameBloc.emit(ConfigurationState(players: [playerToRemove]));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(RemovePlayerEvent(player: playerToRemove));
      },
      expect: () => [
        LoadingState(),
        const ConfigurationState(players: []),
      ],
    );

    blocTest<GameBloc, GameState>(
      'should not remove player if not in array',
      build: () {
        gameBloc.emit(const ConfigurationState(players: []));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(RemovePlayerEvent(player: playerToRemove));
      },
      expect: () => [
        LoadingState(),
        const ConfigurationState(players: []),
      ],
    );
  });

  group('StartGameEvent', () {
    List<String> players = ['tPlayer1', 'tPlayer2', 'tPlayer3'];

    Map<String, String> tGame = {
      'tPlayer1': 'tPlayer3',
      'tPlayer2': 'tPlayer1',
      'tPlayer3': 'tPlayer2'
    };

    blocTest<GameBloc, GameState>(
      'should not emit anything if we are not in the ConfigurationState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const StartGameEvent());
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should not emit anything if we have 2 players or less in state',
      build: () {
        gameBloc
            .emit(const ConfigurationState(players: ['tPlayer1', 'tPlayer2']));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const StartGameEvent());
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>('should call ProcessPlayersTargets()',
        build: () {
      when(processPlayersTargetsUsecase(any)).thenReturn(tGame);
      gameBloc.emit(ConfigurationState(players: players));
      return gameBloc;
    }, act: (bloc) {
      bloc.add(const StartGameEvent());
    }, verify: (_) {
      verify(processPlayersTargetsUsecase(players));
    });

    blocTest<GameBloc, GameState>('should return DisplayPlayerState',
        build: () {
          when(processPlayersTargetsUsecase(any)).thenReturn(tGame);
          gameBloc.emit(ConfigurationState(players: players));
          return gameBloc;
        },
        act: (bloc) {
          bloc.add(const StartGameEvent());
        },
        expect: () => [LoadingState(), isA<DisplayPlayerState>()]);
  });

  group('EndGameEvent', () {
    blocTest<GameBloc, GameState>(
      'should call endgame use case',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const EndGameEvent());
      },
      verify: (_) {
        verify(endGameUsecase());
      },
    );

    blocTest<GameBloc, GameState>(
      'should return empty ConfigurationState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const EndGameEvent());
      },
      expect: () => [LoadingState(), const ConfigurationState(players: [])],
    );
  });

  group('DisplayTargetEvent', () {
    List<String> tPlayers = ['tPlayer1', 'tPlayer2', 'tPlayer3'];

    Map<String, String> tGame = {
      'tPlayer1': 'tPlayer3',
      'tPlayer2': 'tPlayer1',
      'tPlayer3': 'tPlayer2'
    };

    blocTest<GameBloc, GameState>(
      'should not emit anything if we are not in the DisplayPlayerState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayTargetEvent());
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should emit player target in DisplayTargetState',
      build: () {
        gameBloc.currentGame = tGame;
        gameBloc.playersOrder = tPlayers;
        gameBloc.emit(const DisplayPlayerState(player: 'tPlayer1'));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayTargetEvent());
      },
      expect: () =>
          [const DisplayTargetState(killer: 'tPlayer1', target: 'tPlayer3')],
    );

    blocTest<GameBloc, GameState>(
      'should emit ConfigurationState if no target found',
      build: () {
        gameBloc.currentGame = tGame;
        gameBloc.playersOrder = tPlayers;
        gameBloc.emit(const DisplayPlayerState(player: 'tPlayer4'));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayTargetEvent());
      },
      expect: () => [ConfigurationState(players: tPlayers)],
    );
  });

  group('DisplayNextPlayerEvent', () {
    List<String> tPlayers = ['tPlayer1', 'tPlayer2', 'tPlayer3'];

    Map<String, String> tGame = {
      'tPlayer1': 'tPlayer3',
      'tPlayer2': 'tPlayer1',
      'tPlayer3': 'tPlayer2'
    };

    blocTest<GameBloc, GameState>(
      'should not emit anything if we are not in the DisplayTargetState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayNextPlayerEvent());
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should emit DisplayPlayerState with next player',
      build: () {
        gameBloc.currentGame = tGame;
        gameBloc.playersOrder = tPlayers;
        gameBloc.emit(
            const DisplayTargetState(killer: 'tPlayer1', target: 'tPlayer3'));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayNextPlayerEvent());
      },
      expect: () => [const DisplayPlayerState(player: 'tPlayer2')],
    );

    blocTest<GameBloc, GameState>(
      'should emit GameInfoState if we are at last player',
      build: () {
        gameBloc.currentGame = tGame;
        gameBloc.playersOrder = tPlayers;
        gameBloc.emit(
            const DisplayTargetState(killer: 'tPlayer3', target: 'tPlayer2'));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayNextPlayerEvent());
      },
      expect: () => [GameInfoState(players: tPlayers)],
    );
  });

  group('DisplayPlayerTargetEvent', () {
    List<String> tPlayers = ['tPlayer1', 'tPlayer2', 'tPlayer3'];
    Map<String, String> tGame = {
      'tPlayer1': 'tPlayer3',
      'tPlayer2': 'tPlayer1',
      'tPlayer3': 'tPlayer2'
    };

    blocTest<GameBloc, GameState>(
      'should not emit anything if we are not in the GameInfoState',
      build: () {
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayPlayerTargetEvent(player: 'tPlayer1'));
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should not emit anything if we do not found the target',
      build: () {
        gameBloc.playersOrder = tPlayers;
        gameBloc.currentGame = tGame;
        gameBloc.emit(GameInfoState(players: tPlayers));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayPlayerTargetEvent(player: 'tPlayer4'));
      },
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'should emit DisplayTargetState with right target',
      build: () {
        gameBloc.playersOrder = tPlayers;
        gameBloc.currentGame = tGame;
        gameBloc.emit(GameInfoState(players: tPlayers));
        return gameBloc;
      },
      act: (bloc) {
        bloc.add(const DisplayPlayerTargetEvent(player: 'tPlayer1'));
      },
      expect: () => [
        const DisplayTargetState(killer: 'tPlayer1', target: 'tPlayer3'),
        GameInfoState(players: tPlayers)
      ],
    );
  });
}
