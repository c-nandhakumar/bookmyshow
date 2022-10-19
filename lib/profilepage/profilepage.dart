import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './cardgenerator/profilecardgenerator.dart';
import '../loginpagevalidation/google_sign_in_cubit.dart';
import 'cardgenerator/profilecarddetails.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 21, 46),
          title: Column(
            children: [
              Text(
                "Hey!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return signedInScreen(context);
              } else if (snapshot.hasError)
                return Center(child: Text("Oops ! Something went wrong"));
              else {
                return ProfileCard();
              }
            }));
  }

  ListView signedInScreen(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Hello , :${FirebaseAuth.instance.currentUser!.displayName}"),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  final provider = BlocProvider.of<GoogleSignInCubit>(context,
                      listen: false);
                  provider.signOutWithGoogle();
                  FirebaseAuth.instance.signOut();
                },
                child: Text("Log out"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: card2.length,
            itemBuilder: (BuildContext context, int index) {
              return CardGenerator(card2[index]);
            }),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return CardGenerator(cards[index]);
            }),
        Container(
          height: height * 0.20,
        )
      ],
    );
  }
}
