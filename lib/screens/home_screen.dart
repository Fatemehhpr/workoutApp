import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_list/models/data.dart';
import 'package:workout_list/screens/workouts_screen.dart';
import 'package:workout_list/widgets/homeInkwells.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final firstColor = Color(0xff110336);
  final secondColor = Color(0xffFCF2D8);
  
  
  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: firstColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 10, 100),
              child: Container(
                //height: screenHeight / 8,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Dear,',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w300,
                        fontSize: 25
                      ),
                    ),
                    Text(
                      'Lets Workout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Column(
              children: [
                Container(
                  //height: 5 * screenHeight / 8,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    )
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30, 22, 30, 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 22, 32, 0),
                      child: Column(
                        children: [
                          InkwellsWidget(
                            screenWidth: screenWidth,
                            text: 'Upper body workouts',
                            iconImage: 'https://static.thenounproject.com/png/2397485-200.png',
                            mainImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz6ngOGXJNgVBzFhjIUQChh8vcpqGLVIGTrUMM9ZqX1Kkh2bVF9aFTiJOCe1KQkhUGk7Q&usqp=CAU',
                            backgroundColor: secondColor,
                            shadowColor: Color(0xfffaea0c),
                            startId: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkwellsWidget(
                            screenWidth: screenWidth,
                            text: 'Abs workouts',
                            iconImage: 'https://static.thenounproject.com/png/4445375-200.png',
                            mainImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwuULT5skTG0sGOm64nWUlqiMeUpneInrtEg&usqp=CAU',
                            backgroundColor: Color(0xffe9f0e4),
                            shadowColor: Color(0xff5fed8a),
                            startId: 16,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkwellsWidget(
                            screenWidth: screenWidth,
                            text: 'Lower body workouts',
                            iconImage: 'https://static.thenounproject.com/png/659118-200.png',
                            mainImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfjNeh68Af95IodjfwuFfxJwJk3wq7F-z-qw&usqp=CAU',
                            backgroundColor: Color(0xfffaf2f2),
                            shadowColor: Color(0xfff76565),
                            startId: 31,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

