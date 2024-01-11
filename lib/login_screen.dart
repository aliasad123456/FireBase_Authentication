import 'package:ffastpro/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.text, password: userPassword.text);
      SharedPreferences userCred = await SharedPreferences.getInstance();
      userCred.setString("userEmail", userEmail.text);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashBoardScreen(),
            ));
      }
    } on FirebaseAuthException catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ex.code.toString())));
      }
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Email"),
              controller: userEmail,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter Your Password"),
              controller: userPassword,
            ),
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    userLogin();
                  },
                  child: const Text("Login")))
        ],
      ),
    );
  }
}
