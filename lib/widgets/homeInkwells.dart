import 'package:flutter/material.dart';
import 'package:workout_list/models/data.dart';
import 'package:workout_list/screens/workouts_screen.dart';

class InkwellsWidget extends StatelessWidget {
  const InkwellsWidget({
    super.key,
    required this.screenWidth, 
    required this.text, 
    required this.iconImage, 
    required this.mainImage, 
    required this.backgroundColor, 
    required this.shadowColor,
    required this.startId
  });

  final double screenWidth;
  final String text;
  final String iconImage;
  final String mainImage;
  final Color backgroundColor;
  final Color shadowColor;
  final int startId;

  @override
  Widget build(BuildContext context) {
    List<BodyWorkout> workouts = InAppDatabase.bodyWorkouts;

    return Material(
      borderRadius: BorderRadius.circular(40),
      color: backgroundColor,
      shadowColor: shadowColor,
      elevation: 15,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        splashColor: backgroundColor,
        onTap: () {
          workouts = InAppDatabase.bodyWorkouts;
          if (startId == 1) {
            for (var i = 44; i > 14; i--) {
              workouts.removeAt(i);
            }
          }
          else if (startId == 16) {
            for (var i = 44; i > 29; i--) {
              workouts.removeAt(i);
            }
            for (var i = 14; i >= 0; i--) {
              workouts.removeAt(i);
            }
          }
          else {
            for (var i = 29; i >= 0; i--) {
              workouts.removeAt(i);
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => workoutsScreen(
              shadowColor: shadowColor,
              backgroundColor: backgroundColor,
              bodyWorkouts: workouts,
              itemCount: 15,
            )),
          );
        },
        child: Container(
          height: 200,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: 125,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Image.asset('assets/images/upper.png'),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              iconImage,
                              height: 35,
                              width: 35,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            '15 exercises',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 200,
                //   width: 180,
                //   //color: Colors.blue,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(40),
                //     child: Image.network(
                //       mainImage,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}