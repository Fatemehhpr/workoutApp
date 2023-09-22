import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class authForm extends StatefulWidget {
  const authForm({
    super.key,
    required this.submitF,
    required this.isLoading
  });

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitF;

  @override
  State<authForm> createState() => _authFormState();
}

class _authFormState extends State<authForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _submit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formkey.currentState?.save();
      widget.submitF(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstColor = Color(0xff13054d);
    final secondColor = Color(0xffFCF2D8);
    final thirdColor = Colors.grey.shade500;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return 
    Center(
      child: 
        Container(
          height: screenHeight/2.5,
          width: 340,
          color: secondColor,
          //margin: EdgeInsets.all(200),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if ((value!.isEmpty)) {
                          return 'this field can not be empty.';
                        }
                        else if (!value!.contains('@')) {
                          return 'plaese enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: thirdColor),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: thirdColor),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.zero, 
                          child: Icon(
                            CupertinoIcons.envelope_fill,
                            color: firstColor,
                            size: 24,
                          ), 
                        ),
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: thirdColor,
                          fontSize: 12
                        )
                      ),
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if ((value?.isEmpty ?? true) || value!.length < 4) {
                          return 'please enter at least 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: thirdColor),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: thirdColor),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.zero, 
                          child: Icon(
                            CupertinoIcons.person_crop_circle, 
                            size: 24,
                            color: firstColor,
                          ), 
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: thirdColor,
                          fontSize: 12
                        )
                      ),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if ((value?.isEmpty ?? true) || value!.length < 7) {
                          return 'password must be at least 7 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: thirdColor),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: thirdColor),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.zero, 
                          child: Icon(
                            CupertinoIcons.lock_fill, 
                            size: 24,
                            color: firstColor,
                          ), 
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: thirdColor,
                          fontSize: 12
                        )
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.isLoading)
                      CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: firstColor,
                          shadowColor: firstColor,
                          elevation: 10
                        ),
                        child: Text(_isLogin ?
                          'Login' : 'SignUp',
                          style: TextStyle(
                            color: secondColor,
                          ),
                        ),
                        onPressed: _submit
                      ),
                    if (!widget.isLoading)
                      SizedBox(
                        height: 12,
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        child: Text(_isLogin ?
                          'Create new account' : 'I already have an account',
                          style: TextStyle(
                            color: firstColor,
                            shadows: [
                              Shadow(
                                color: firstColor,
                                blurRadius: 2.0,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}