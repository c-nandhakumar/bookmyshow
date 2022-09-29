import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInInitial());
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get useraccount => _user!;

  Future signInWithGoogle() async {
    final googleUser = await googleSignin.signIn();

    if (googleUser == null) {
      return;
    }

    _user = googleUser;

    final googleAuthentication = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signOutWithGoogle() async {
    final googleUser = await googleSignin.signOut();
    _user = googleUser;
  }
}
