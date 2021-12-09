part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class AddPlayerEvent extends GameEvent {
  final String player;

  const AddPlayerEvent({required this.player});

  @override
  List<Object> get props => [player];
}

class RemovePlayerEvent extends GameEvent {
  final String player;

  const RemovePlayerEvent({required this.player});

  @override
  List<Object> get props => [player];
}

class StartGameEvent extends GameEvent {
  const StartGameEvent();

  @override
  List<Object> get props => [];
}

class ResumeGameEvent extends GameEvent {
  const ResumeGameEvent();

  @override
  List<Object> get props => [];
}

class EndGameEvent extends GameEvent {
  const EndGameEvent();

  @override
  List<Object> get props => [];
}

class DisplayTargetEvent extends GameEvent {
  const DisplayTargetEvent();

  @override
  List<Object> get props => [];
}

class DisplayNextPlayerEvent extends GameEvent {
  const DisplayNextPlayerEvent();

  @override
  List<Object> get props => [];
}

class DisplayPlayerTargetEvent extends GameEvent {
  final String player;

  const DisplayPlayerTargetEvent({required this.player});

  @override
  List<Object> get props => [player];
}
