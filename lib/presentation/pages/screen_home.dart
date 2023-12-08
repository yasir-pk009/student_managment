import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';
import 'package:student_managment/data/student_repo.dart';
import 'package:student_managment/presentation/pages/screen_filter.dart';
import 'package:student_managment/presentation/pages/screen_search.dart';
import 'package:student_managment/presentation/pages/widgets/addporfile.dart';
import 'package:student_managment/presentation/pages/widgets/drawer.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('user posts')
          .orderBy("name")
          .snapshots();
  File? imageFile;

  void handleAddProfilePic(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return UploadProfilePictureWidget(
          onchanged: (file) {
            setState(() {
              imageFile = file;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: loginPagetextcolor,
        onPressed: () {
          createNewStudent(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawerScrimColor: Colors.white,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: loginPagetextcolor,
        elevation: 0,
        title: const Center(
          child: Text(
            "STUDENT MANAGEMENT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchView(),
                      ),
                    );
                  },
                  child: const Icon(Icons.search),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenFilter(),
                      ),
                    );
                  },
                  child: const Icon(Icons.filter_list),
                ),
              ],
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final post = snapshot.data!.docs[index];

                return Card(
                  margin: const EdgeInsets.all(16),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: FileImage(File(post["imageUrl"])),
                    ),
                    title: Text(post['name']),
                    subtitle: Text("Age: ${post['age']}"),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void createNewStudent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
       
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
            "Add Student",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 12,),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  handleAddProfilePic(context);
                },
                child: const Text(
                  "Select Image ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: loginPagetextcolor,
                    ),
                    onPressed: () {
                      if (imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a picture!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (!isNumeric(ageController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter a Valid Age"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (nameController.text.isEmpty || ageController.text.isEmpty ){
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Enter Name"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      StudentRepo.instance.addStudent(
                        nameController.text,
                        int.parse(ageController.text),
                        imageFile!.path,
                      );
                      nameController.clear();
                      ageController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "ADD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
