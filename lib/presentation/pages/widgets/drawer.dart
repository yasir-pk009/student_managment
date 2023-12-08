
import 'package:flutter/material.dart';
import 'package:student_managment/core/colors.dart';
import 'package:student_managment/data/auth_repo.dart';
import 'package:student_managment/presentation/pages/widgets/tile_drawer.dart';

class DrawerWidget extends StatelessWidget {

 

  const DrawerWidget({
    super.key,

   
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: loginPagetextcolor,
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.person,
                size: 70,
                color: drawerIcon,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerListTile(
                icon: const Icon(Icons.home, color: drawerIcon),
                text: "H O M E",
                ontap: () => Navigator.of(context).pop(),
              ),
              // DrawerListTile(
              //   icon: const Icon(Icons.person, color: drawerIcon),
              //   text: "P R O F I L E",
              //   ontap: () {
                  
              //   },
              // ),
            ],
          ),
          Expanded(child: Container()), 
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DrawerListTile(
              icon: const Icon(Icons.logout, color: drawerIcon),
              text: "S I G N O U T",
              ontap: signOut,
            ),
          ),
        ],
      ),
    );
  }

  signOut() {

    AuthRepo.instance.signout();

  }
}
