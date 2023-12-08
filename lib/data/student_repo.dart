import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentRepo {

  StudentRepo._internal();
  static StudentRepo instance = StudentRepo._internal();
  factory StudentRepo() {
    return instance;
  }





  final User? currectUser = FirebaseAuth.instance.currentUser;

  
  void addStudent(String name ,int age,String imageUrl){
    FirebaseFirestore.instance
      .collection("user posts").add({
        "name":name,
        "age":age,
        "imageUrl":imageUrl
      });
  }


// void addPost(String name, String age, String imageUrl) {
//   FirebaseFirestore.instance
//       .collection("user posts")
//       .doc(currectUser!.email)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       // If the document already exists, update the array
//       List<Map<String, dynamic>> posts =
//           List.from((documentSnapshot.data() as Map<String, dynamic>)['posts']);
//       posts.add({"name": name, "age": age, "imageUrl": imageUrl});

//       FirebaseFirestore.instance
//           .collection("user posts")
//           .doc(currectUser!.email)
//           .update({"posts": posts});
//     } else {
//       // If the document doesn't exist, create a new one with the array
//       FirebaseFirestore.instance
//           .collection("user posts")
//           .doc(currectUser!.email)
//           .set({"posts": [{"name": name, "age": age, "imageUrl": imageUrl}]});
//     }
//   });
// }


}
