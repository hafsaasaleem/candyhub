import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showOrderPlaceDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    imageUrl: "updated-details.png",
    title: "Are want to Place Order?",
    content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit proin et orci in quam.",
    optionsBuilder: () => {
      "Cancel": false,
      "Confirm": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
