import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.onTap,
    this.icon = Icons.add,
  }) : super(key: key);

  final Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 4.5, 4, 4.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: TowermarketColors.black,
          shape: BoxShape.rectangle,
        ),
        child: Icon(
          icon,
          size: 12,
          color: TowermarketColors.white,
        ),
      ),
    );
  }
}
