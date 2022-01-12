import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:killer_party_companion/features/game-management/data/datasources/local_storage_datasource.dart';
import 'package:killer_party_companion/features/game-management/data/repositories/local_storage_game_repository.dart';
import 'package:killer_party_companion/features/game-management/domain/repositories/game_repository.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/end_game.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/process_players_targets.dart';
import 'package:killer_party_companion/features/game-management/domain/usecases/resume_game.dart';
import 'package:killer_party_companion/features/game-management/presentations/blocs/game_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencyInjection() async {
  // Features

  // -- Game management

  // ---- Presentation
  getIt.registerFactory(() => GameBloc(
      resumeGameUsecase: getIt(),
      processPlayersTargetsUsecase: getIt(),
      endGameUsecase: getIt()));

  // ---- Domain
  getIt.registerLazySingleton(() => ResumeGame(repository: getIt()));
  getIt.registerLazySingleton(() => ProcessPlayersTargets(repository: getIt()));
  getIt.registerLazySingleton(() => EndGame(repository: getIt()));

  // ---- Data
  getIt.registerLazySingleton<GameRepository>(
      () => LocalStorageGameRepository(datasource: getIt()));

  getIt.registerLazySingleton<GameLocalDatasource>(
      () => GameLocalDatasourceImpl(sharedPreferences: getIt()));

  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
