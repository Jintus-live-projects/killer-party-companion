import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:killer_party_companion/features/game-management/presentations/widgets/list_cell_wiget.dart';

enum PlayerCellIcon {
  delete,
  view,
}

class PlayerCellWidget extends StatelessWidget {
  final String playerName;
  final PlayerCellIcon cellIcon;

  const PlayerCellWidget(
      {Key? key, required this.cellIcon, required this.playerName})
      : super(key: key);

  IconData _getCellIcon() {
    switch (cellIcon) {
      case PlayerCellIcon.delete:
        return Icons.delete_forever;
      case PlayerCellIcon.view:
        return Icons.remove_red_eye;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListCellWidget(
      child: Text(
        playerName,
        style: GoogleFonts.poppins(color: const Color(0xFFA3A9B4)),
      ),
      iconData: _getCellIcon(),
    );
  }
}
