import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/CommonFiles/loading_button.dart';
import 'package:wikolo/CommonFiles/utils.dart';
import 'package:wikolo/CommonFiles/response_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final controller = CardFormEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorLocalPink,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(""),
            ),
          ],
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              'Payment',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardFormField(
                controller: controller,
                style: CardFormStyle(
                  borderColor: Colors.blueGrey,
                  textColor: Colors.black,
                  fontSize: 24,
                  placeholderColor: Colors.blue,
                ),
              ),
              LoadingButton(
                onPressed: controller.details.complete == true
                    ? _handlePayPress
                    : null,
                text: 'Pay',
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => controller.focus(),
                      child: Text('Focus'),
                    ),
                    SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => controller.blur(),
                      child: Text('Blur'),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 20),
              ResponseCard(
                response: controller.details.toJson().toPrettyString(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePayPress() async {
    if (!controller.details.complete) {
      return;
    }

    try {
      // 1. Gather customer billing information (ex. email)

      final billingDetails = BillingDetails(
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

      // 2. Create payment method
      final paymentMethod =
          await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: billingDetails,
        ),
      ));

      // 3. call API to create PaymentIntent
      final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
        useStripeSdk: true,
        paymentMethodId: paymentMethod.id,
        currency: 'usd', // mocked data
        items: [
          {'id': 'id'}
        ],
      );

      if (paymentIntentResult['error'] != null) {
        // Error during creating or confirming Intent
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == null) {
        // Payment succedeed

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Success!: The payment was confirmed successfully!')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == true) {
        // 4. if payment requires action calling handleNextAction
        final paymentIntent = await Stripe.instance
            .handleNextAction(paymentIntentResult['clientSecret']);

        // todo handle error
        /*if (cardActionError) {
        Alert.alert(
        `Error code: ${cardActionError.code}`,
        cardActionError.message
        );
      } else*/

        if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
          // 5. Call API to confirm intent
          await confirmIntent(paymentIntent.id);
        } else {
          // Payment succedeed
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${paymentIntentResult['error']}')));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(
        paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success!: The payment was confirmed successfully!')));
    }
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse('$baseUrl/charge-card-off-session');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    final url = Uri.parse('$baseUrl/pay-without-webhooks');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'useStripeSdk': useStripeSdk,
        'paymentMethodId': paymentMethodId,
        'currency': currency,
        'items': items
      }),
    );
    return json.decode(response.body);
  }
}
