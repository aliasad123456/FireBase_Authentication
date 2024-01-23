import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffastpro/UserCrud/user_add.dart';
import 'package:ffastpro/UserCrud/user_update.dart';
import 'package:flutter/material.dart';

class fetchScreen extends StatefulWidget {
  const fetchScreen({super.key});

  @override
  State<fetchScreen> createState() => _fetchScreenState();
}

class _fetchScreenState extends State<fetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("userData").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            var dataLength = snapshot.data!.docs.length;
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateUser()
                        ));
                },
                child: const Text('Add User'),),
                ListView.builder(
                  itemCount: dataLength,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                    String uName = snapshot.data!.docs[index]["User-Name"];
                    String uEmail = snapshot.data!.docs[index]["User-Email"];
                    String uID = snapshot.data!.docs[index]["User-ID"];
                    String uAge = snapshot.data!.docs[index]["User-Age"];
                    String uPassword = snapshot.data!.docs[index]["User-Password"];
                    String uAddress =snapshot.data!.docs[index]["User-Address"];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => updateScreen(userID: uID,userName: uName, userPassword: uPassword, userEmail: uEmail, userAddress: uAddress, userAge: uAge)));
                      },
                    child: ListTile(
                      title: Text(uName),
                      subtitle: Text(uEmail),
                      trailing: IconButton(onPressed: () async{
                        await FirebaseFirestore.instance.collection("userData").doc(uID).delete();
                      },
                        icon: const Icon(Icons.delete),),
                    ),
                    );
                  },
                )
              ],
            );
          }  
          return Container();
        },
      ),
    );
  }
}
