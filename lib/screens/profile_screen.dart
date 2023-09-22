import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workout_list/providers/userIdProvider.dart';
import 'package:workout_list/screens/auth_screen.dart';

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  List userProfile = [];

  Future<DocumentSnapshot> getUserProfile(BuildContext ctx) async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(ctx?.read<userId>().getId).get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<userId>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: getUserProfile(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator while retrieving data
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          userProfile.add(snapshot.data!['email']);
          userProfile.add(snapshot.data!['username']);

          return Container(
            height: screenHeight,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 42, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'username : ${userProfile[1]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'email : ${userProfile[0]}',
                    style: TextStyle(
                      fontWeight:FontWeight.w300,
                      fontSize: 16,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff13054d),
        icon: Icon(Icons.exit_to_app_rounded, color: Colors.white,),
        label: Text('LogOut', style: TextStyle(color: Colors.white,),),
        onPressed: () async{
          await FirebaseFirestore.instance.collection('users').get().then(
            (data) {
              for (var i = 0; i < data.docs.length; i++) {
                if (user.getId == data.docs[i].id) {
                  data.docs[i].reference.delete();
                }
              }
            }
          );

          FirebaseAuth.instance.currentUser!.delete();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => authScreen()),
          );
        },
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}