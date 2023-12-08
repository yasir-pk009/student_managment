


// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_managment/domain/models/user_model.dart';

class AuthRepo {
  AuthRepo._internal();
  static AuthRepo instance = AuthRepo._internal();
  factory AuthRepo() {
    return instance;
  }

  void signIn(UserModel userValue, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userValue.email, password: userValue.password);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      showErrorMessage(e.code, context);
            // Navigator.of(context).pop();


    }
  }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      rethrow;
    }
  }

  void showErrorMessage(String code, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(code,style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
          );
        });
  }


void signInWithGoogle() async {
  try {
    // Trigger Google Sign In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    
    // Get authentication details from GoogleSignInAccount
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a credential using the obtained authentication details
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    // Access the user information
    final User? user = authResult.user;

    // Check if the user is signed in
    if (user != null) {
      print('Successfully signed in with Google: ${user.displayName}');
    } else {
      print('Failed to sign in with Google');
    }
  } catch (error) {
    print('Error signing in with Google: $error');
    // Handle the error as needed
  }
}


void signInWithPhoneNumber(String phoneNumber) async {
  try {
    // Start the phone number verification process
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // This callback will be triggered automatically if the verification is completed without user interaction (e.g., on Android)
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Access the user information
        final User? user = authResult.user;

        // Check if the user is signed in
        if (user != null) {
          print('Successfully signed in with phone number: ${user.phoneNumber}');
        } else {
          print('Failed to sign in with phone number');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Error verifying phone number: $e');
        // Handle the verification failure as needed
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID somewhere to use it later
        // Typically, you would send the verification ID to a screen where the user can enter the code
        print('Verification code sent. ID: $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the auto-retrieval timeout has passed (e.g., 120 seconds)
        // Handle the situation as needed (e.g., prompt the user to enter the code manually)
        print('Auto retrieval timeout. ID: $verificationId');
      },
      timeout: Duration(seconds: 60), // Timeout for code entry in seconds
    );
  } catch (error) {
    print('Error signing in with phone number: $error');
    // Handle the error as needed
  }
}


}
