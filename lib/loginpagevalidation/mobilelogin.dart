import 'package:bookmyshow/landingpage/landingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MobileLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MobileLoginState();
  }
}

class MobileLoginState extends State<MobileLogin> {
  TextEditingController phoneController = TextEditingController();
  int screenState = 0;
  String otpPin = "";
  String countryDial = "+91";
  String verificationID = "";

  Future<void> verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        showSnackBar("Auth Completed");
      },
      verificationFailed: (FirebaseException e) {
        showSnackBar("Auth Failed");
      },
      codeSent: ((verificationId, forceResendingToken) {
        showSnackBar("OTP sent");
        verificationID = verificationId;
        setState(() {
          screenState = 1;
        });
      }),
      codeAutoRetrievalTimeout: (verificationId) {
        showSnackBar("Time Out!");
      },
    );
  }

  Future<void> verifyOTP() async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: otpPin))
        .whenComplete(() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingPage())));
  }

  void showSnackBar(String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txt)));
  }

  @override
  Widget build(BuildContext context) {
    Widget verifyOtp() {
      return Container(
          child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Verify your mobile number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter OTP sent to ${countryDial + phoneController.text}",
              style: TextStyle(fontSize: 12.5, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: ((value) => {otpPin = value}),
            pinTheme: PinTheme(
              activeColor: Colors.blue,
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Didn\'t receive any code? ',
                style: TextStyle(color: Colors.grey)),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    screenState = 0;
                  });
                },
                child: Text(
                  "Resend",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            )
          ])),
        ],
      ));
    }

    Widget mobileLogin() {
      return Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Login with Mobile Number",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialValue: countryDial,
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    setState(() {
                      countryDial = "+" + country.dialCode;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        setState(() {
          screenState = 0;
        });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: const IconThemeData(
            color: Colors.grey, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              screenState == 0 ? mobileLogin() : verifyOtp(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (screenState == 0) {
                        if (phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Phone number is Empty")));
                        } else {
                          verifyPhone(countryDial + phoneController.text);
                        }
                      } else {
                        if (otpPin.length >= 6) {
                          verifyOTP();
                        } else {
                          showSnackBar('Enter valid OTP');
                        }
                      }
                    });
                  },
                  child: Text("Verify"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
