// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:echonest/presentation/login/widgets/likebottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListviewTile extends StatelessWidget {
  final String age;
  final String name;
  final String imageUrl;

   ListviewTile({
    super.key,
    
     required this.imageUrl, required this.age, required this.name,
    
  });

  final User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            
             CircleAvatar(
             
              backgroundColor: Colors.black, 
              radius: 20, 
              child: Image.asset("assets/smartphone-and-mobile-phone-free-png.webp"),
            ),
            const SizedBox(width: 10),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    name,
                    style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    age,
                    style: const  TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
