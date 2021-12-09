import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(InitialState()) {
    on<AddPlayerEvent>((event, emit) => throw UnimplementedError());
    on<RemovePlayerEvent>((event, emit) => throw UnimplementedError());
    on<StartGameEvent>((event, emit) => throw UnimplementedError());
    on<ResumeGameEvent>((event, emit) => throw UnimplementedError());
    on<EndGameEvent>((event, emit) => throw UnimplementedError());
    on<DisplayTargetEvent>((event, emit) => throw UnimplementedError());
    on<DisplayNextPlayerEvent>((event, emit) => throw UnimplementedError());
    on<DisplayPlayerTargetEvent>((event, emit) => throw UnimplementedError());
  }
}
