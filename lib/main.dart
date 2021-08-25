import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_provider/constants.dart';
import 'package:flutter_provider/provider/auth_provider.dart';
import 'package:flutter_provider/provider/provide_state.dart';
import 'package:flutter_provider/provider/provider_state.dart';
import 'package:flutter_provider/ui/auth/login_screen.dart';
import 'package:flutter_provider/constants.dart';
import 'package:flutter_provider/ui/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> ProvideState())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        );
      },

    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isTablet;
  bool isLogin = false;
  late ProvideState providerState;

  startTime() async {
    getSession();
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }
  route()
  {
    isLogin ?
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()))
        :
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

  }
  getSession() async{
    var pref = SharedPreferences.getInstance() as SharedPreferences;
    isLogin = (await pref.getBool('isLogin'))!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    isTablet = Constants().isTabletDevice();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Increment And Decrement', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            Text('Using Provider',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal)),
            Padding(
              padding: const EdgeInsets.all(30),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


