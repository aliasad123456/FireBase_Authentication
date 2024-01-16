import 'package:ffastpro/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  void userSignOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              userSignOut();
            },
            child: Text("${FirebaseAuth.instance.currentUser!.email}")),
      ),
    );
  }
}
