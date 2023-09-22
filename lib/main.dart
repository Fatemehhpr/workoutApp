import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:workout_list/providers/userIdProvider.dart';
import 'package:workout_list/screens/auth_screen.dart';
import 'package:workout_list/screens/home_screen.dart';
import 'package:workout_list/screens/personalWorkouts_screen.dart';
import 'package:workout_list/screens/profile_screen.dart';
import 'package:workout_list/widgets/navigationBar.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => userId(),
      child : const MyApp()
    ),
    
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff110336)),
        primaryColor: Color(0xff110336),
        useMaterial3: true,
      ),
      home: authScreen(),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return navigationBarControl();
      //     }
      //     return authScreen();
      //   },
      // ), 
    );
  }
}


