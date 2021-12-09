part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialState extends GameState {
  @override
  List<Object> get props => [];
}

class ConfigurationState extends GameState {
  final List<String> players = [];

  ConfigurationState();

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
  final String target;

  const DisplayTargetState({required this.target});

  @override
  List<Object> get props => [target];
}

class GameInfoState extends GameState {
  final List<String> players;
  final Map<String, String> game;

  GameInfoState({required this.game}) : players = game.keys.toList();

  @override
  List<Object> get props => [game];
}
