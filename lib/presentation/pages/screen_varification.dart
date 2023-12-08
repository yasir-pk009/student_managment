import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';
import 'package:student_managment/data/auth_repo.dart';
import 'package:student_managment/presentation/pages/screenOtp.dart';
import 'package:student_managment/presentation/pages/widgets/newtest.dart';
import 'package:student_managment/presentation/pages/widgets/textfield.dart';

class ScreenNumber extends StatelessWidget {
  ScreenNumber({Key? key}) : super(key: key);

  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: loginPagetextcolor,
        title: const Text(
          'Phone Number Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            MytextField(hinttext: "Enter Your Phone Number",controller: _phoneNumberController, ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_phoneNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Enter a  Number"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (_phoneNumberController.text.length <= 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Enter Valid Phone Number!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  String phoneNumber = _phoneNumberController.text.trim();

                  AuthRepo.instance.signInWithPhoneNumber(phoneNumber);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScreenOtp()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: loginPagetextcolor,
              ),
              child: const Text(
                'Send Verification Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
