import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/CommonFiles/loading_button.dart';

class PaymentSheetScreen extends StatefulWidget {
  @override
  _PaymentSheetScreenState createState() => _PaymentSheetScreenState();
}

class _PaymentSheetScreenState extends State<PaymentSheetScreen> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: Column(
        children: [
          Stepper(
            // controlsBuilder: emptyControlBuilder,
            currentStep: step,
            steps: [
              Step(
                title: Text('Init payment'),
                content: LoadingButton(
                  onPressed: initPaymentSheet,
                  text: 'Init payment sheet',
                ),
              ),
              Step(
                title: Text('Confirm payment'),
                content: LoadingButton(
                  onPressed: confirmPayment,
                  text: 'Pay now',
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('$baseUrl/payment-sheet');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'customer': 'cus_Lovn9B9OuAxIF9',
      }),
    );
    final body = json.decode(response.body);
    if (body['error'] != null) {
      throw Exception(body['error']);
    }
    return body;
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await _createTestPaymentSheet();

      // create some billingdetails
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret:
              "sk_test_51L6u98SEXYrIxBUKexslnsPPD40IbHyDKnjQnWQ5WhQkC66CbO5JM0Duh1lFxiK2c0neXJOZkddExGrzZox9Ijdz00kjKlbmD8",
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // Customer params
          customerId: data['customer'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          // Extra params
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          billingDetails: billingDetails,
          testEnv: true,
          merchantCountryCode: 'DE',
        ),
      );
      setState(() {
        step = 1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> confirmPayment() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        step = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment succesfully completed'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: ${e}'),
          ),
        );
      }
    }
  }
}
