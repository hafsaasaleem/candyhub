import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/candyhub_text_style.dart';

class PaymentMethodScreen extends StatelessWidget {
  static Route<PaymentMethodScreen> route() {
    return CupertinoPageRoute(
        builder: (context) => const PaymentMethodScreen());
  }

  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              child: ListTile(
                leading: Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                ),
                title: Text("Cash on Delivery"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Pay now",
                style: CandyHubTextStyle.heading4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
