import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class UPIScreen extends StatefulWidget {
  const UPIScreen({super.key});

  @override
  State<UPIScreen> createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {
  List<PaymentItem> get _paymentItems {
    const paymentItems = [
      PaymentItem(
          amount: "60.00",
          label: "Movie1",
          status: PaymentItemStatus.final_price)
    ];
    return paymentItems;
  }

  // final Pay _payClient = Pay.withAssets([
  //   'lottie/google_pay.json',
  // ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPI"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Column(children: [
          Container(
            height: 40,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: const Color.fromARGB(255, 225, 231, 234),
            child: const Text(
              "Choose an UPI app",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          InkWell(
            onTap: () async {
              // final result = await _payClient.showPaymentSelector(
              //   provider: PayProvider.google_pay,
              //   paymentItems: _paymentItems,
              // );
              // print(result.toString());
            },
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const Image(
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/logos/gpay_logo.png"),
                ),
              ),
              title: const Text("Google Pay"),
            ),
          ),
          const Divider(),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                image: AssetImage("assets/logos/phonepe.png"),
              ),
            ),
            title: const Text("PhonePe"),
          ),
        ]),
      ),
      // bottomNavigationBar:
      //  GooglePayButton(
      //   paymentConfigurationAsset: 'lottie/google_pay.json',
      //   paymentItems: _paymentItems,
      //   type: GooglePayButtonType.pay,
      //   onPaymentResult: onGooglePayResult,
      //   loadingIndicator: const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }

  void onGooglePayResult(Map<String, dynamic> result) {
    print(result.toString());
  }
}
