import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class OpenApplePaySetup extends StatefulWidget {
  const OpenApplePaySetup({Key? key}) : super(key: key);

  @override
  _OpenApplePaySetupState createState() => _OpenApplePaySetupState();
}

class _OpenApplePaySetupState extends State<OpenApplePaySetup> {
  Future<void> openApplePaySetup() async {
    await Stripe.instance.openApplePaySetup();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    openApplePaySetup();
                  },
                  child: Text('Open apple pay setup')),
            )
          ],
        ),
      ),
    );
  }
}
