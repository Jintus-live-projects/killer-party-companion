part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialState extends GameState {
  @override
  List<Object> get props => [];
}

class LoadingState extends GameState {
  @override
  List<Object> get props => [];
}

class ConfigurationState extends GameState {
  final List<String> players;

  const ConfigurationState({required this.players});

  @override
  List<Object> get props => [players];
}

class DisplayPlayerState extends GameState {
  final String player;

  const DisplayPlayerState({required this.player});

  @override
  List<Object> get props => [player];
}

class DisplayTargetState extends GameState {
  final String killer;
  final String target;

  const DisplayTargetState({required this.killer, required this.target});

  @override
  List<Object> get props => [target];
}

class GameInfoState extends GameState {
  final List<String> players;
  const GameInfoState({required this.players});

  @override
  List<Object> get props => [players];
}
