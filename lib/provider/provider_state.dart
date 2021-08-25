import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_provider/model/user_model.dart';

class ProviderState extends ChangeNotifier
{
  String? _Uid, _Email;

  String? get getUID => _Uid;

  String? get getEmail => _Email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;


  Future<bool> CreateUserAccount(UserModel userModel) async
  {
    print('called');
  bool success = false;
  print(success);
    await _auth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    ).then((auth) {
      firebaseUser = auth.user!;
    }).catchError((onError){
      print('onError=> $onError');
    });

    if(firebaseUser != null)
    {
      saveUserInfoToFireStore(firebaseUser!, userModel).then((value){
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

  Future<bool> SignInUserAccount(String email, String password) async
  {
    bool success = false;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      if(userCredential != null)
      {
        _Uid = userCredential.user!.uid;
        _Email = userCredential.user!.email!;

        return success = true;
      }
    }
    catch(e)
    {

    }
    return success;
  }

  void signOut() async{
    await _auth.signOut();
  }
}