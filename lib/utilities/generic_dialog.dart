import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String imageUrl,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Column(
          children: [
            Image.asset("assets/icons/$imageUrl",
                height: 52, width: 52, color: TowermarketColors.brick),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TowermarketTextStyle.title2
                  .copyWith(fontWeight: FontWeight.w600)
                  .copyWith(color: TowermarketColors.brick),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TowermarketTextStyle.title2,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowButtonSpacing: 0,
        contentPadding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 8.0),
        titlePadding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        actionsPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return InkWell(
            onTap: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              width: 78,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: options.length > 1
                    ? value
                        ? TowermarketColors.brick
                        : TowermarketColors.peru
                    : TowermarketColors.brick,
              ),
              child: Text(
                optionTitle,
                style: TowermarketTextStyle.title2
                    .copyWith(color: TowermarketColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
