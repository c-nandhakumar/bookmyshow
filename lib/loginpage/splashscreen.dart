import 'dart:async';
import 'package:bookmyshow/bottomnavigation/bottomnavigator.dart';
import 'package:bookmyshow/loginpage/nointernet.dart';
import 'package:bookmyshow/loginpagevalidation/home_page.dart';
import 'package:bookmyshow/widgets/testing.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import '/loginpage/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription subscription;
  var hasInternet = true;
  bool isAlertSet = false;

  @override
  void initState() {
    //getConnectivity();
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
        if (hasInternet) {
          Timer(
              Duration(seconds: 3),
              () =>
                  Navigator.pushReplacementNamed(context, HomePage.routeName));
        } else {
          Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NoInternet())));
        }
      });
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (event) async {
          hasInternet = await InternetConnectionChecker().hasConnection;
          if (!hasInternet && isAlertSet == false) {
            setState(() {
              showDialogBox();
              isAlertSet = true;
            });
          }
        },
      );

  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text("Please Check Your Internet Connection"),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                    setState(() {
                      isAlertSet = false;
                    });
                    hasInternet =
                        await InternetConnectionChecker().hasConnection;
                    if (!hasInternet) {
                      showDialogBox();
                      setState(() {
                        isAlertSet = true;
                      });
                    }
                  },
                  child: Text('Retry'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/icons/PngItem_1896899.png'),
              width: 150,
              fit: BoxFit.contain,
            ),
            const Text(
              'It All Starts Here',
              style: TextStyle(
                color: Color.fromARGB(255, 97, 89, 89),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2.8,
                height: MediaQuery.of(context).size.height / 6.0,
                child: IntrinsicHeight(
                  child: Lottie.asset(
                    'assets/lottie/dotLoader.json',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
