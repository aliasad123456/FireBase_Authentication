import 'package:ffastpro/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void userRegister()async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail.text, password: userPassword.text);
      userEmail.clear();
      userPassword.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    } on FirebaseAuthException catch(ex){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter Your Email"
              ),
              controller: userEmail,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter Your Password"
              ),
              controller: userPassword,
            ),
          ),

          Center(child: ElevatedButton(onPressed: (){
            userRegister();
          }, child: const Text("Register"))),

          Center(child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
          }, child: const Text("Login")))
        ],
      ),
    );
  }
}