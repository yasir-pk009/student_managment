
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';
import 'package:student_managment/data/auth_repo.dart';
import 'package:student_managment/presentation/pages/widgets/image.tile.dart';
import 'package:student_managment/presentation/pages/widgets/signBotton.dart';
import 'package:student_managment/presentation/pages/widgets/textfield.dart';


class RegisterPage extends StatefulWidget {
  final  Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
 final nameController = TextEditingController();
 
 

  @override
  void dispose() {
    emailTextController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    
     super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
            
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "Hello!",
               
                style: TextStyle(color: loginPagetextcolor, fontSize: 30,fontWeight: FontWeight.bold,),
              ),
               const Text(
                 "Welcome ",
              
                style: TextStyle(color: loginPagetextcolor, fontSize: 30,fontWeight: FontWeight.bold,),
              ),
              const SizedBox(
                height: 30,
              ),
              MytextField(
                hinttext: "Name",
                obscure: false,
                controller: nameController,
                icon: IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
              ),
            
              MytextField(
                hinttext: "Email",
                obscure: false,
                controller: emailTextController,
                 icon: IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
              ),
              MytextField(
                hinttext: "Password",
                obscure: true,
                controller: passwordController,
                 icon: IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
              ),
              MytextField(
                hinttext: "Confirm Password",
                obscure: true,
                controller: confirmPasswordController,
                 icon: IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SignBotton(onTap: signUp, text: "Sign Up"),
              ),
              const SizedBox(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have an Account",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                    const SizedBox(
                width: 10,
              ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          color: loginPagetextcolor, fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  )
                ],
              ),
           
              const SizedBox(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageTile(
                    ontap: () {
                      AuthRepo.instance.signInWithGoogle();
                      
                    },
                    
                    imagePath: "assets/google.jpeg",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ImageTile(
                    ontap: () {
                      
                    },
                    imagePath:  "assets/smartphone-and-mobile-phone-free-png.webp",
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
             
            ],
          ),
        ),
      )),
    );
  }

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          {
            return const Center(child: CircularProgressIndicator());
          }
        });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        //create user
     final UserCredential userInfo =   await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailTextController.text, password: passwordController.text);

        //add created user details 
       
        FirebaseFirestore.instance.collection("Users-collection").doc(userInfo.user!.email).set({
          "username": emailTextController.text.split("@")[0],
          "email":emailTextController.text,
         "name": nameController.text


        });

      }


      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String code) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(code)),
          );
        });
  }
}
