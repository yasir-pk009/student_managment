import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';

class ScreenFilter extends StatefulWidget {
  const ScreenFilter({super.key});

  @override
  State<ScreenFilter> createState() => _SearchViewState();
}

class _SearchViewState extends State<ScreenFilter> {
  var minAge = "0";
  var maxAge = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.white), 

        backgroundColor: loginPagetextcolor,
        title: const Text('FILTER SCREEN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        minAge = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Min Age',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        maxAge = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Max Age',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user posts')
                  .orderBy('age')
                  .startAt([minAge]).endAt([maxAge + "\uf8ff"]).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = snapshot.data!.docs[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
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
          ),
        ],
      ),
    );
  }
}
