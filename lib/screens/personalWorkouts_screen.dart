import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workout_list/models/data.dart';
import 'package:workout_list/providers/userIdProvider.dart';
import 'package:workout_list/screens/workouts_screen.dart';

class personalWorkoutsScreen extends StatefulWidget {
  
  @override
  State<personalWorkoutsScreen> createState() => _personalWorkoutsScreenState();
}

class _personalWorkoutsScreenState extends State<personalWorkoutsScreen> {
  Future<List<DocumentSnapshot>> getDocs(BuildContext ctx) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(ctx?.read<userId>().getId).collection('personalWorkouts').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<userId>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 12
            ),
            child: Text(
              'delete all',
              style: TextStyle(
                color: Colors.black45,
                
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 42, 0),
            child: IconButton(
              icon: Icon(CupertinoIcons.delete_solid, color: Colors.black,),
              onPressed: () async{
                await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').get().then(
                  (data) {
                    for (var element in data.docs) {
                      element.reference.delete();
                    }
                  }
                );
                setState(() {
                  personalWorkoutsScreen();
                });
              },
            ),
          )
        ],
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getDocs(context),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator while retrieving data
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          
          List<DocumentSnapshot>? documents = snapshot.data;
          List<BodyWorkout> allWorkouts = InAppDatabase.bodyWorkouts;
          List<BodyWorkout> personalWorkouts = <BodyWorkout>[];
          List<bool> isDoneList = [];
          for (int i = 0; i < documents!.length; i++) {
            for (var j = 0; j < 45; j++) {
              if (documents[i].id == allWorkouts[j].id.toString()) {
                isDoneList.add(documents[i]['isDone']);
                personalWorkouts.add(allWorkouts[j]);
                break;
              }
            }
          }
          for (var element in isDoneList) {
            print(element);
            print(isDoneList.length);
          }
          

          return ListView.builder(
            itemCount: documents.length,
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            itemBuilder: (context, index) {
              final workout = personalWorkouts[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff13054d),
                  shadowColor: Color(0xff13054d),
                  elevation: 6,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      workoutsScreenState().showDetails(context, workout);
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight / 6,
                      margin: const EdgeInsets.fromLTRB(12, 0, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: screenHeight / 15,
                                width: screenHeight / 15 + 10,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    workout.imageAddress,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                workout.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(CupertinoIcons.delete_simple, color: Colors.white,),
                                onPressed: () async{
                                  await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).delete();
                                  setState(() {
                                    personalWorkouts.remove(index);
                                  });
                                },
                              ),
                              IconButton(
                                icon: isDoneList.elementAt(index)
                                      ? Icon(CupertinoIcons.check_mark_circled_solid, color: Color(0xff7e82ab),) 
                                      : Icon(CupertinoIcons.check_mark_circled, color: Color(0xff7e82ab),),
                                onPressed: () async{
                                  bool temp = await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).get().then(
                                    (data) {
                                      return data['isDone'];
                                    }
                                  );
                                  
                                  setState(() {
                                    isDoneList[index] = !temp;
                                  });

                                  if (isDoneList[index] == true) {
                                    await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).update({
                                      'isDone': true,
                                    });
                                  }
                                  else {
                                    await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).update({
                                      "isDone" : false,
                                    });
                                  }

                                },
                              )
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
          // return ListView.builder(
          //   itemCount: documents.length,
          //   shrinkWrap: true,
          //   padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          //   itemBuilder:(context, index) {
              
          //     final workout = personalWorkouts[index];
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         height: 30,
          //         width: 30,
          //         color: Colors.red,
          //       ),
          //     );

          //   },
          // );
        },
      ),


      // body: ListView.builder(
      //   itemCount: personalWorkouts.length,
      //   itemBuilder: (context, index) {
      //     final workout = personalWorkouts[index];

      //     return Padding(
      //       padding: EdgeInsets.all(8),
      //       child: Container(
      //         color: Colors.red,
      //       ),
      //     );
      //   }
      // ),
    );
  }
}