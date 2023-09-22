

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_list/screens/home_screen.dart';
import 'package:workout_list/screens/personalWorkouts_screen.dart';
import 'package:workout_list/screens/profile_screen.dart';

class navigationBarControl extends StatefulWidget {
  @override
  State<navigationBarControl> createState() => _navigationBarControlState();
}

class _navigationBarControlState extends State<navigationBarControl> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xff7e82ab),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.house_fill),
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Personal workouts',
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person_circle_fill),
            icon: Icon(CupertinoIcons.person_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        homeScreen(),
        personalWorkoutsScreen(),
        profileScreen(),
      ][currentPageIndex],
    );
  }
}