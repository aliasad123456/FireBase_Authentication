import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userAge = TextEditingController();

  // void addUser()async{
  //   Map<String, dynamic> uAdd = {
  //     "User-Name" : userName.text,
  //     "User-Address": userAddress.text,
  //     "User-Age": userAge.text,
  //     "User-Email": userEmail.text,
  //     "User-Password": userPassword.text
  //   };
  //   await FirebaseFirestore.instance.collection("userData").add(uAdd);
  // }

  void addUser() async {
    String userID = const Uuid().v1();

    Map<String, dynamic> uAdd = {
      "User-ID": userID,
      "User-Name": userName.text,
      "User-Address": userAddress.text,
      "User-Age": userAge.text,
      "User-Email": userEmail.text,
      "User-Password": userPassword.text
    };
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(userID)
        .set(uAdd);
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
              controller: userName,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Address"),
              controller: userAddress,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter Your Age"),
              controller: userAge,
            ),
          ),
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
                    addUser();
                  },
                  child: const Text("Add User")))
        ],
      ),
    );
  }
}
