import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:killer_party_companion/features/game-management/presentations/blocs/game_bloc.dart';
import 'package:killer_party_companion/features/game-management/presentations/widgets/add_player_textfield_widget.dart';
import 'package:killer_party_companion/features/game-management/presentations/widgets/player_cell_widget.dart';

class RegisterPlayersPage extends StatelessWidget {
  final ConfigurationState state;

  const RegisterPlayersPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Configurer votre partie',
                style: GoogleFonts.poppins(
                    color: const Color(0xFF4F5560),
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: AddPlayerTextFieldWidget(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.players.length,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (index == 0)
                        const SizedBox(
                          height: 24.0,
                        ),
                      PlayerCellWidget(
                        playerName: state.players[index],
                        cellIcon: PlayerCellIcon.delete,
                      ),
                      const SizedBox(
                        height: 24.0,
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF5A55CA),
                          padding: const EdgeInsets.symmetric(vertical: 10.0)),
                      child: Text(
                        'C\'est parti !',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
