import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';
import 'package:student_managment/presentation/pages/widgets/textfield.dart';

class ScreenOtp extends StatelessWidget {
  ScreenOtp({super.key});

  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: loginPagetextcolor,
        title: const Text(
          'Verification Code',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MytextField(
              hinttext: "Enter Verification Code",
              controller: _codeController,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String verificationCode = _codeController.text.trim();
                // Call the function to complete phone number verification
                // (you might need to pass the verification code to your authentication function)
                //  AuthRepo.instance.completePhoneNumberVerification(verificationCode);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: loginPagetextcolor,
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
