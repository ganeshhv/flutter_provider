import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/model/user_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth? _auth;
  User? _user;
  Status _status = Status.Uninitialized;


  Status get status => status;
  User get user => user;


  Future<bool> CreateUserAccount(UserModel userModel) async
  {
    print('called');
    bool success = false;
    print(success);
    await _auth?.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    ).then((auth) {
      _user = auth.user!;
    }).catchError((onError){
      print('onError=> $onError');
    });

    if(_user != null)
    {
      saveUserInfoToFireStore(_user!, userModel).then((value){
        print('success');
        success = true;
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (c) =>LoginScreen()
        // ));
      }).catchError((error) {
        print('register error: $error');
        success = false;

      });
    }
    return success;
  }

  Future saveUserInfoToFireStore(User fUser, UserModel userModel) async
  {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "pwd": userModel.password,
      "name": userModel.name,
      "phone": userModel.phoneNumber,
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth?.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth?.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}