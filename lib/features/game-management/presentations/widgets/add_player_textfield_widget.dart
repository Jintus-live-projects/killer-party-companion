import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:killer_party_companion/features/game-management/presentations/widgets/list_cell_wiget.dart';

class AddPlayerTextFieldWidget extends StatelessWidget {
  const AddPlayerTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellWidget(
        child: Expanded(
          child: TextField(
            decoration: null,
            style: GoogleFonts.poppins(color: const Color(0xFFA3A9B4)),
          ),
        ),
        iconData: Icons.person_add);
  }
}
