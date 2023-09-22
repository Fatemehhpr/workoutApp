import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_list/models/data.dart';
import 'package:workout_list/providers/userIdProvider.dart';
import 'package:workout_list/screens/personalWorkouts_screen.dart';
import 'package:workout_list/widgets/detailsBottomSheet.dart';


class workoutsScreen extends StatefulWidget {
  Color? shadowColor;
  Color? backgroundColor;
  late List<BodyWorkout> bodyWorkouts;
  int itemCount;

  workoutsScreen({
    required this.shadowColor,
    required this.backgroundColor,
    required this.bodyWorkouts,
    required this. itemCount,
  });


  @override
  State<workoutsScreen> createState() => workoutsScreenState();
}

class workoutsScreenState extends State<workoutsScreen> {

  Color _iconColor = Colors.black;
  List<bool> isAdd = List<bool>.filled(15, false, growable: true);


  void showDetails(BuildContext ctx, BodyWorkout workout) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25)
        )
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: workoutDetails(workout: workout),
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    final user = context.read<userId>();
    
    //final upperBodyWorkouts = InAppDatabase.bodyWorkouts;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.itemCount,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        itemBuilder: (context, index) {
          final workout = widget.bodyWorkouts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor,
              shadowColor: widget.shadowColor,
              elevation: 6,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  showDetails(context, widget.bodyWorkouts[index]);
                },
                child: Container(
                  width: screenWidth,
                  height: screenHeight / 6,
                  margin: const EdgeInsets.fromLTRB(12, 0, 4, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
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
                            Expanded(
                              child: Text(
                                workout.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: isAdd.elementAt(index) 
                              ? Icon(CupertinoIcons.add_circled_solid) 
                              : Icon(CupertinoIcons.add_circled),
                        onPressed: () async{
                          setState(() {
                            isAdd[index] = !isAdd[index];
                          });
                          
                          if (isAdd[index] == true) {
                            print(user.getId);
                            await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).set({
                              'isDone': false,
                            });
                          }
                          else {
                            await FirebaseFirestore.instance.collection('users').doc(user.getId).collection('personalWorkouts').doc(workout.id.toString()).delete();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}