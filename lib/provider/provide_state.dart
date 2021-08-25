import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvideState extends ChangeNotifier{
  String? _uid;
  String? _email;
  Map? _userData;
  String? get getUid =>_uid;
  String? get getEmail => _email;
  Map? get userDetails => _userData;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;


  Future<bool> signUpUser(String email,String password, Map? model) async{
    bool retval = false;

    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((auth) {
      firebaseUser = auth.user!;
      retval = true;
      print('registre');
    }).catchError((onError){
      print('onError=> $onError');
      retval = false;
    });
      if(firebaseUser != null)
      {
        saveUserInfoToFireStore(firebaseUser!, model).then((value){
          print('success');
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (c) =>LoginScreen()
          // ));
        }).catchError((error) {
          print('register error: $error');
          retval = false;

        });
      }
    return retval;
  }
  Future saveUserInfoToFireStore(User fUser, Map? model) async
  {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "pwd": model!['pwd'],
      "name": model['name'],
      "phone": model['phone'],
      "value": model['value']
    });
  }

  Future<bool> LoginUser(String email,String password) async{
    bool retval = false;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null)
      {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;
        print('Login Success');
        return retval = true;
      }
    }catch(e)
    {
      print(e);
    }
    return retval;
  }

  Future<bool> signout() async
  {
    bool rtnval = false;
    await _auth.signOut().then((value) {
      print('logout');
      return rtnval = true;
    }).catchError((onError){
      return rtnval = false;
    });
    return rtnval;
  }

  Future getUserName() async {
    print('getuname called');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getUid)
    // .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
          _userData =
          {
            'name': value.get('name'),
            'value': value.get('value')
          };

    });
    print(_userData);
    return _userData;
  }

  updateUserData(String? uid, Map model) async
  {
    print('${getUid} -> ${model}');
    bool rtnval = false;
    print(_uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getUid)
        .update(
        {'value': model['value']})
        .then((_) {
          print('updated');
          rtnval = true;
    })
        .catchError((onError){
          print(onError);
          rtnval = false;
    });
    return rtnval;
  }

}