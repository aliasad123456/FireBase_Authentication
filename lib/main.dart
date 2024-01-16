import 'dart:async';
import 'package:ffastpro/dashboard_screen.dart';
import 'package:ffastpro/firebase_options.dart';
import 'package:ffastpro/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserCrud/user_add.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateUser(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future getUserCred()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    return userCred.getString("userEmail");
  }

  @override
  void initState() {
    // TODO: implement initState

    getUserCred().then((value) {
      if(value != null ){
        Timer(const Duration(milliseconds: 3000), () => Navigator.push(context, MaterialPageRoute(builder:  (context) => DashBoardScreen(),)),);
      }
      else{
        Timer(const Duration(milliseconds: 3000), () => Navigator.push(context, MaterialPageRoute(builder:  (context) => MyHome(),)),);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Splash Screen"),),
    );
  }
}



