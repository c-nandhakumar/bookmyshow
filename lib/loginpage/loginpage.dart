import 'dart:math';

import 'package:bookmyshow/bottomnavigation/bottomnavigator.dart';
import 'package:bookmyshow/provider/googlesignin_provider.dart';
import 'package:bookmyshow/loginpage/frontscrollable.dart';
import 'package:bookmyshow/loginpagevalidation/home_page.dart';
import 'package:bookmyshow/loginpagevalidation/mobilelogin.dart';

import 'package:bookmyshow/profilepage/profilepage.dart';
import 'package:bookmyshow/widgets/testfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../landingpage/landingpage.dart' as page;

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: UserInterface());
  }
}

class UserInterface extends StatefulWidget {
  const UserInterface({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserInterfaceState();
  }
}

class UserInterfaceState extends State<UserInterface> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool hidden = true;
  void isTapped() {
    setState(() {
      hidden = !hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsets.all(width / 25),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        num = 0;
                      });
                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //       pageBuilder:
                      //           (context, animation, secondaryAnimation) =>
                      //               ListenableProvider(
                      //                 create: (context) => animation,
                      //                 child: const BottomNavigation(),
                      //               ),
                      //       transitionDuration: Duration(milliseconds: 200)),
                      // );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BottomNavigation()));
                    },
                    child: const Text(
                      "SKIP",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Container(
                height: height * 0.2,
                child: const FrontScrollables(),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width / 70),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 129, 129, 129),
                    ),
                  ),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInCubit>(context, listen: false);
                  provider.signInWithGoogle();
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => BottomNavigation(),
                  // ));
                },
                child: buildLoginButton(height, width),
              ),
            ),
            SizedBox(
              height: height / 75,
            ),
            Container(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width / 70),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 129, 129, 129)),
                  ),
                ),
                child: emailLayout(height, width),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            const Text(
              "OR",
              style: TextStyle(color: Color.fromARGB(255, 109, 107, 107)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height / 75,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextFormField(
                enableInteractiveSelection: false,
                focusNode: new AlwaysDisabledFocusNode(),
                readOnly: true,
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MobileLogin())),
                decoration: const InputDecoration(
                  label: Text(
                    'Continue with phone number',
                    style: TextStyle(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container emailLayout(double height, double width) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(width / 25),
        child: Row(
          children: [
            Icon(
              Icons.email_outlined,
              color: Colors.black87,
              size: width / 17,
            ),
            Spacer(),
            Center(
              // widthFactor: width / 220,
              child: const Text(
                "Continue with Email",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 129, 129, 129)),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void pageNavigator(BuildContext context, var googleAccount) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const BottomNavigation()));
  }

  Container buildLoginButton(double height, double width) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(width / 25),
        child: Row(
          children: [
            Image(
              alignment: Alignment.centerLeft,
              image: AssetImage("assets/icons/Google.png"),
              height: height / 35,
            ),
            Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Continue with Google",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 129, 129, 129)),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
