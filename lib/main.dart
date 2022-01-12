import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:killer_party_companion/features/game-management/presentations/blocs/game_bloc.dart';
import 'package:killer_party_companion/features/game-management/presentations/pages/register_players_page.dart';
import 'package:killer_party_companion/injection_container.dart';

void main() async {
  await initDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => getIt<GameBloc>(),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Scaffold(
                body: Center(child: Text("Loading")),
              );
            } else if (state is ConfigurationState) {
              return RegisterPlayersPage(state: state);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
