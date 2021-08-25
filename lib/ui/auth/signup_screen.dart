import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/model/user_model.dart';
import 'package:flutter_provider/provider/auth_provider.dart';
import 'package:flutter_provider/provider/provide_state.dart';
import 'package:flutter_provider/provider/provider_state.dart';
import 'package:flutter_provider/ui/auth/login_screen.dart';
import 'package:flutter_provider/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<ScaffoldState>();

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _contactController = TextEditingController();

  void _signUp(String email,String password,BuildContext context) async{
    ProvideState _providerState = Provider.of<ProvideState>(context,listen: false);
    if(_formKeyName.currentState!.validate() &&
        _formKeyPhone.currentState!.validate() &&
        _formKeyEmail.currentState!.validate() &&
        _formKeyPassword.currentState!.validate())
      {
        Map? userModel = {
          'name' : _nameController.text.trim(),
          'phone' : _contactController.text.trim(),
          'pwd' : _pwdController.text.trim(),
          'value' : 0
        };

        bool status = await _providerState.signUpUser(email, password, userModel);
        print('status');
        if(status)
        {
          showDialog(
              context: context,
              builder: (context)
              {
                return AlertDialog(
                  content: Text('User Registeration successfull'),
                );
              }
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
        else
        {
          print('error');
        }
      }
  }

  bool obscure = true;
  obscureText()
  {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        print('device: $deviceType');

        // ignore: unrelated_type_equality_checks
        if(deviceType == DeviceType.mobile)
          {
            return Scaffold(
              key: _key,
              body: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 85.w,
                      height: 75.h,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Firebase And Provider Example',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('SIGN UP',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKeyName,
                              child: TextFormField(
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'Please enter Name';
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      hintText: 'name',
                                      labelText: 'Enter name',
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey, //this has no effect
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKeyPhone,
                              child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'Please enter Phonenumber';
                                    }
                                  },
                                  controller: _contactController,
                                  // keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Phone Number',
                                      labelText: 'Contact',
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey, //this has no effect
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  )
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKeyEmail,
                              child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    else if (!validEmail(value))
                                      return 'Please enter valid email';
                                  },
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      labelText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey, //this has no effect
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKeyPassword,
                              child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    else if (value.toString().length < 8)
                                      return 'Password shoud be 8 characters';
                                  },
                                  obscureText: obscure,
                                  controller: _pwdController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(obscure == true ? Icons.visibility : Icons.visibility_off),
                                        onPressed: obscureText,
                                      ),
                                      hintText: 'Password',
                                      labelText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey, //this has no effect
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  // print('signin');
                                  _signUp(_emailController.text, _pwdController.text, context);
                                  // registerUser(_emailController.text, _pwdController.text, context);
                                  // register();
                                },
                                child: Text('SignUp',style: TextStyle(color: Colors.white),)
                            ),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'already have an account?',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: 'Login',
                                        style: TextStyle(color: Colors.blue),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                          }
                                    )
                                  ]
                              ))

                        ],
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )],
                        borderRadius: BorderRadius.circular(36),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        else
          return Scaffold(
            key: _key,
            body: Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  width: 500,
                  height: 500,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Firebase And Provider Example',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('SIGN UP',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKeyName,
                          child: TextFormField(
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter Name';
                                }
                              },
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: 'name',
                                  labelText: 'Enter name',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKeyPhone,
                          child: TextFormField(
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter Phonenumber';
                                }
                              },
                              controller: _contactController,
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  labelText: 'Contact',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              )
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Form(
                          key: _formKeyEmail,
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                else if (!validEmail(value))
                                  return 'Please enter valid email';
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKeyPassword,
                          child: TextfieldWidget(
                              validate: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                }
                                else if (value.toString().length < 8)
                                  return 'Password shoud be 8 characters';
                              },
                              obscureText: obscure,
                              controller: _pwdController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(obscure == true ? Icons.visibility : Icons.visibility_off),
                                    onPressed: obscureText,
                                  ),
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ElevatedButton(
                            onPressed: () {
                              print('signin');
                              _signUp(_emailController.text, _pwdController.text, context);
                              // registerUser(_emailController.text, _pwdController.text, context);
                              // register();
                            },
                            child: Text('SignUp',style: TextStyle(color: Colors.white),)
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'already have an account?',
                              children: [
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                      }
                                )
                              ]
                          ))

                    ],
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )],
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
  // registerUser(String email, String password,BuildContext context) async
  // {
  //   final user = Provider.of<AuthProvider>(context);
  //
  //   print('async');
  //   UserModel? userModel;
  //   userModel?.email = _emailController.text.trim();
  //   userModel?.name = _nameController.text.trim();
  //   userModel?.phoneNumber = _contactController.text.trim();
  //   userModel?.password = _pwdController.text.trim();
  //
  //     await user.CreateUserAccount(userModel!);
  //
  // }

  FirebaseAuth _auth = FirebaseAuth.instance;

  register() async{
    User? firebaseUser;

    await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _pwdController.text.trim(),
    ).then((auth) {
      firebaseUser = auth.user!;
    }).catchError((onError){
      Navigator.pop(context);
      print('onError=> $onError');
    });

    if(firebaseUser != null)
      {
        saveUserInfoToFireStore(firebaseUser!).then((value){
          print('success');
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (c) =>LoginScreen()
          // ));
        }).catchError((error) {
          print('register error: $error');
        });
      }
  }

  Future saveUserInfoToFireStore(User fUser) async
  {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "pwd": _pwdController.text.trim(),
      "name": _nameController.text.trim(),
      "phone": _contactController.text.trim(),
    });
  }




  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
