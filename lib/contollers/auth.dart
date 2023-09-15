import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // creating new account using email password method
  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created Successfully";
    } on FirebaseAuthException catch (err) {
      return err.message.toString();
    }
  }

  // login with email and password
  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Logged In Successfully";
    } on FirebaseAuthException catch (err) {
      return err.message.toString();
    }
  }

  // check whether user is signin or not
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // logic for google sign in
  Future<String> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // sending the auth request
      final GoogleSignInAuthentication gAuth = await googleUser!.authentication;
      // obtain the new credentials

      final creds = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //  signin with the new credentials
      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Login Successfull";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // logic for facebook auth
  Future continueWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        return "Login Successfull";
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {
      print("Some error occured while logging in");
    }
  }

  // logout the user
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    // logout from google if logged in with google
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }

    // logout from facebook
    // final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    // if (accessToken != null) {
      await FacebookAuth.instance.logOut();
    // }
  }
}
