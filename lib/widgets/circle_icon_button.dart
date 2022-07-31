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
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          color: TowermarketColors.black,
          shape: BoxShape.circle,
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
