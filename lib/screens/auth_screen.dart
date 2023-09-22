import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_list/providers/userIdProvider.dart';
import 'package:workout_list/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_list/widgets/navigationBar.dart';

class authScreen extends StatefulWidget {
  const authScreen({super.key});

  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  final firstColor = Color(0xff13054d);
  final secondColor = Color(0xffFCF2D8);

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async{
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        ctx.read<userId>().setId(userCredential.user!.uid);
        ctx.read<userId>().setAuth(_auth);
      }
      else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        ctx.read<userId>().setId(userCredential.user!.uid);
        ctx.read<userId>().setAuth(_auth);

        await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
          'username': username,
          'email': email
        });
      }

      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => navigationBarControl()),
      );



    } on PlatformException catch (error) {
      //any error thrown by fierbase because of invalid fileds for example
      var message = 'error, please check your fields';

      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        )
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('error, please check your fields'),
          backgroundColor: Theme.of(context).errorColor,
        )
      );
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            height:4*screenHeight/8,
            width: screenWidth,
            child: Container(
              height:4*screenHeight/8,
              width: screenWidth,
              decoration: BoxDecoration(
                color: firstColor,
              ),
            ),
          ),
          Positioned(
            top: 0,
            height:6.2*screenHeight/8,
            width: screenWidth,
            child: Container(
              height:6*screenHeight/8,
              width: screenWidth,
              decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(110),
                  bottomRight: Radius.circular(110),
                ),
              ),
            ),
          ),
          authForm(
            submitF: _submitAuthForm,
            isLoading: _isLoading
          ),
          Positioned(
            top: 0,
            left: screenWidth/3,
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Color(0xfff5dcae),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)
                )
              ),
            ),
          ),
          Positioned(
            top: screenHeight/5,
            left: 0,
            child: Container(
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                color: firstColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100)
                )
              ),
            ),
          ),
          Positioned(
            top: screenHeight/3,
            right: 0,
            child: Container(
              height: 150,
              width: 75,
              decoration: BoxDecoration(
                color: Color(0xffc25f4c),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100)
                )
              ),
            ),
          ),
          
        ],
      )
    );
  }
}