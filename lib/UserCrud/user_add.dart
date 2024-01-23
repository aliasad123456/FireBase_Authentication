//import 'dart:html';
//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class CreateUser extends StatefulWidget {


  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userAge = TextEditingController();


  bool isLoading = false;
  File? userProfile;
  //File? userProfile;
  // void addUser()async{
  //   Map<String, dynamic> uAdd = {
  //     "User-Name" : userName.text,
  //     "User-Address": userAddress.text,
  //     "User-Age": userAge.text,
  //     "User-Email": userEmail.text,
  //     "User-Password": userPassword.text
  //   };
  //   await FirebaseFirestore.instance.collection("userData").add(uAdd);

  void addUserWithImage() async {
    setState(() {
      isLoading =true;
    });

  String userID = const Uuid().v1();
  UploadTask uploadTask = FirebaseStorage.instance.ref().child("UserImage").child(userID).putFile(userProfile!);

  TaskSnapshot taskSnapshot = await uploadTask;
  String userImage = await  taskSnapshot.ref.getDownloadURL();
//  addUser(userID: userID,imgUrl: userImage);
    addUser(imgUrl: userImage, userID: userID);
  setState(() {
    isLoading = false;
  });
    }



  void addUser({String? imgUrl, String? userID}) async {
    String userID = const Uuid().v1();

    Map<String, dynamic> uAdd = {
      "User-ID": userID,
      "user-Image": imgUrl,
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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);

                if(pickImage != null){
                  File convertedImage = File(pickImage.path);
                  setState(() {
                    userProfile = convertedImage;
                  });
                } else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not picked")));
                }
              },
            ),
            Center(
              child: CircleAvatar(
                radius: 10,
                  backgroundColor: Colors.blue,
                  backgroundImage: userProfile != null ? FileImage(userProfile!) : null,
              ),
            ),
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
                      addUserWithImage();
                    },
                    child: const Text("Add User")))
          ],
        ),
      ),
    );
  }
}
