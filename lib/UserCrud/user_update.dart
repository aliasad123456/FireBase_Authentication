import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class updateScreen extends StatefulWidget {
  const updateScreen({super.key,
    required this.userName,
    required this.userPassword,
    required this.userEmail,
    required this.userAddress,
    required this.userAge,
    required this.userID});

  final String userName;
  final String userEmail;
  final String userAge;
  final String userPassword;
  final String userAddress;
  final String userID;


  @override
  State<updateScreen> createState() => _updateScreenState();
}

class _updateScreenState extends State<updateScreen> {

  TextEditingController uEmail = TextEditingController();
  TextEditingController uPassword = TextEditingController();
  TextEditingController uName = TextEditingController();
  TextEditingController uAddress = TextEditingController();
  TextEditingController uAge = TextEditingController();

  void updateUser() async{
    await FirebaseFirestore.instance.collection("userData").doc(widget.userID).update(
    {
      "User-Name": uName.text,
      "User-Address": uAddress.text,
      "User-Age": uAge.text,
      "User-Email": uEmail.text,
      "User-Password": uPassword.text
    }
    );
    Navigator.pop(context);

  }

  @override
  void initState() {
    // TODO: implement initState
    uName.text = widget.userName;
    uAge.text = widget.userAge;
    uAddress.text = widget.userAddress;
    uPassword.text = widget.userPassword;
    uEmail.text = widget.userEmail;
    super.initState();
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
              decoration: const InputDecoration(hintText: "Enter Your Name"),
              controller: uName,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Address"),
              controller: uAddress,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Age"),
              controller: uAge,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Email"),
              controller: uEmail,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration:
              const InputDecoration(hintText: "Enter Your Password"),
              controller: uPassword,
            ),
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    updateUser();
                  },
                  child: const Text("Update User")))
        ],
      ),
    );;
  }
}

