import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderState extends ChangeNotifier {
  late String _email;
  late String _uid;
  late String password;

// getters
  String get email => _email;
  String get uid => _uid;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // set up method for user registration
  Future<bool> signUp(String email, String password) async {
    bool retval = false;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email!;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }
    return retval;
  }

// login method
  Future<bool> logIn(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email!;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }
    return retval;
  }
  // logout user

  void logOut() async {
    await _auth.signOut();
  }

  // create database
  Future<void> addUserToDatabase(
      {required String firstname,
      required String lastname,
      required String password,
      required String email}) {
    CollectionReference _users =
        FirebaseFirestore.instance.collection('/users');
    return _users
        .add({
          'email': email,
          'firstname': firstname,
          'lastname': lastname,
          'password': password,
        })
        .then((value) => print('user added'))
        .catchError((error) => print(error));
  }

  // get logged in user
  
    CollectionReference users = FirebaseFirestore.instance.collection('users');

  
}
