import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class userId extends ChangeNotifier {
  String? userUid;
  FirebaseAuth? auth;

  String? get getId {
    return userUid;
  }

  void setId(String? id) {
    userUid = id;
  }

  FirebaseAuth? get getAuth {
    return auth;
  }

  void setAuth(FirebaseAuth auth) {
    this.auth = auth;
  }

}