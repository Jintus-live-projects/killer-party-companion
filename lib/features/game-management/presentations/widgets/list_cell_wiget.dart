import 'package:flutter/material.dart';

class ListCellWidget extends StatelessWidget {
  final Widget child;
  final IconData iconData;

  const ListCellWidget({Key? key, required this.child, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(10),
              offset: const Offset(1, 6),
              blurRadius: 15)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child,
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF1F4FF),
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color: const Color(0xFF929CB4),
            ),
          )
        ],
      ),
    );
    ;
  }
}
