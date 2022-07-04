import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showSuccessfullyOrderPlaceDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    imageUrl: "updated.png",
    title: "Your order succesfully Place!",
    content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit proin et orci in quam.",
    optionsBuilder: () => {
      "Back": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
