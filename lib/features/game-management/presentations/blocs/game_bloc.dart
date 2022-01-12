import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/end_game.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/process_players_targets.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/resume_game.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final ResumeGame resumeGameUsecase;
  final ProcessPlayersTargets processPlayersTargetsUsecase;
  final EndGame endGameUsecase;

  @visibleForTesting
  Map<String, String>? currentGame;

  @visibleForTesting
  List<String>? playersOrder;

  GameBloc(
      {required this.resumeGameUsecase,
      required this.processPlayersTargetsUsecase,
      required this.endGameUsecase})
      : super(InitialState()) {
    on<AddPlayerEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is ConfigurationState) {
        emit(LoadingState());
        List<String> players = [...currentState.players];
        if (!currentState.players.contains(event.player)) {
          players.add(event.player);
        }
        emit(ConfigurationState(players: players));
      }
    });

    on<RemovePlayerEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is ConfigurationState) {
        emit(LoadingState());
        List<String> players = [...currentState.players];
        players.remove(event.player);
        emit(ConfigurationState(players: players));
      }
    });

    on<StartGameEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is ConfigurationState &&
          currentState.players.length > 2) {
        emit(LoadingState());
        Map<String, String> game =
            processPlayersTargetsUsecase(currentState.players);
        List<String> players = _getPlayersFromGame(game);
        currentGame = game;
        playersOrder = players;
        emit(DisplayPlayerState(player: players.first));
      }
    });

    on<ResumeGameEvent>((event, emit) {
      Map<String, String>? game = resumeGameUsecase();
      currentGame = game;
      if (game != null) {
        List<String> players = _getPlayersFromGame(game);
        playersOrder = players;
        emit(GameInfoState(players: players));
      } else {
        emit(const ConfigurationState(players: []));
      }
    });

    on<EndGameEvent>((event, emit) {
      emit(LoadingState());
      endGameUsecase();
      currentGame = null;
      playersOrder = null;
      emit(const ConfigurationState(players: []));
    });

    on<DisplayTargetEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is DisplayPlayerState && currentGame != null) {
        String? target = currentGame![currentState.player];
        if (target != null) {
          emit(DisplayTargetState(killer: currentState.player, target: target));
        } else {
          emit(ConfigurationState(players: playersOrder ?? []));
        }
      }
    });

    on<DisplayNextPlayerEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is DisplayTargetState && playersOrder != null) {
        int currentIndex = playersOrder!.indexOf(currentState.killer);
        if (currentIndex == (playersOrder!.length - 1)) {
          emit(GameInfoState(players: playersOrder!));
        } else if (currentIndex >= 0) {
          emit(DisplayPlayerState(player: playersOrder![++currentIndex]));
        }
      }
    });

    on<DisplayPlayerTargetEvent>((event, emit) {
      GameState currentState = state;
      if (currentState is GameInfoState &&
          currentGame != null &&
          playersOrder != null) {
        String? target = currentGame![event.player];
        if (target != null) {
          emit(DisplayTargetState(killer: event.player, target: target));
          emit(GameInfoState(players: playersOrder!));
        }
      }
    });

    add(const ResumeGameEvent());
  }

  List<String> _getPlayersFromGame(Map<String, String> game) {
    List<String> players = game.keys.toList();
    players.shuffle();
    return players;
  }
}
