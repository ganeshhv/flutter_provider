import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/provide_state.dart';
import 'package:flutter_provider/provider/provider_state.dart';
import 'package:flutter_provider/ui/auth/signup_screen.dart';
import 'package:flutter_provider/ui/home/home_screen.dart';
import 'package:flutter_provider/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
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
            print('mobile called');
            return Scaffold(
              body: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    width: 85.w,
                    height: 100.w,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Firebase And Provider Example',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('SIGN IN',
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
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
                          padding: const EdgeInsets.all(5.0),
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
                          padding: const EdgeInsets.all(11.0),
                          child: ElevatedButton(
                              onPressed: (){
                                _Login(_emailController.text, _pwdController.text, context);
                              },
                              child: Text('Login',style: TextStyle(color: Colors.white),)
                          ),
                        ),
                        TextButton(
                          child: Text('create new account',
                              style: TextStyle(color: Colors.blue)
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                          },
                        )

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
          }
        else
          {
            return Scaffold(
              body: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    width: 70.w,
                    height: 70.w,
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
                          child: Text('SIGN IN',
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        // ignore: unrelated_type_equality_checks
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKeyEmail,
                            child: TextFormField(

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
                              onPressed: (){
                                _Login(_emailController.text, _pwdController.text, context);
                              },
                              child: Text('Login',style: TextStyle(color: Colors.white),)
                          ),
                        ),
                        TextButton(
                          child: Text('create new account',
                              style: TextStyle(color: Colors.blue)
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                          },
                        )

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
          }
      },
    );
  }
  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _Login(String email,String password,BuildContext context) async{
    ProvideState _providerState = Provider.of<ProvideState>(context,listen: false);
    if (_formKeyEmail.currentState!.validate() &&
        _formKeyPassword.currentState!.validate()){
      try{
        bool loginStatus = await _providerState.LoginUser(email, password);
        print(loginStatus);
        if(loginStatus == true)
        {
          storeSession();
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context)=>HomeScreen()));
        }
        else
        {
          return showDialog(
              context: context,
              builder: (context)
              {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('something went wrong!'),
                );
              }
          );
        }
      }catch(e)
      {
        print(e);
      }
    }
  }

  void storeSession() async {
    var sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;
    await sharedPreferences.setBool('isLogin', true);
  }
}
