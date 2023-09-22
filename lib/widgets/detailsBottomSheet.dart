import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workout_list/models/data.dart';

class workoutDetails extends StatelessWidget {
  workoutDetails({
    required this.workout,
  });

  BodyWorkout workout;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                workout.imageAddress,
                height: screenHeight / 3,
                width: screenWidth / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Name of the workout : ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Colors.black54
                    ),
                  ),
                  Text(
                    workout.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Row(
                children: [
                  Text(
                    'Suggested sets number : ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Colors.black54
                    ),
                  ),
                  Text(
                    workout.workoutReps,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Text(
                workout.description,
                style: TextStyle(
                  color: Colors.black87
                ),
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}