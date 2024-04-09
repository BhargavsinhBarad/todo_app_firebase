import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signup(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    log("${res}");
    return res;
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }
}
