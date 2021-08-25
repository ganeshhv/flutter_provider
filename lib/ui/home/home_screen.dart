import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/provide_state.dart';
import 'package:flutter_provider/provider/provider_state.dart';
import 'package:flutter_provider/ui/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:numberpicker/numberpicker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 0;
  String text = '';
  ProvideState? providerState;
  var data;
  String name = '';
  int prevValue = 0;
  bool isUpdated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    print('init state : $data');
  }

  showName(){
    setState(() {
      name = data['name'];
    });
  }

  showLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build name: $name');
    print('build called: $name');
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('HI ${name}', style: TextStyle(color: Colors.black),),
              Text('Increment or ddecrement the Number'),
              Text('For each user the value will stored in db'),
              Text('UID: ${providerState?.getUid}'),
              Text('Email: ${providerState?.getEmail}'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _currentHorizontalIntValue == 0 ? null :
                    setState(() {
                      text = 'minus';
                      final newValue = _currentHorizontalIntValue - 1;
                      _currentHorizontalIntValue = newValue.clamp(0, 100);
                    }),
                  ),
                  Text('$_currentHorizontalIntValue'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => setState(() {
                      text = 'plus';
                      final newValue = _currentHorizontalIntValue + 1;
                      _currentHorizontalIntValue = newValue.clamp(0, 100);
                    }),
                  ),
                ],
              ),
              Text(text == '' ? ' ' : text == 'plus' ? 'value Incremented' : 'value Decremented'),

              TextButton(onPressed: () async{
                updateDetails();
                bool route = await providerState!.signout();
                route
                    ? Navigator.pushReplacement(
                    context, MaterialPageRoute(
                    builder: (context)=>LoginScreen()))
                    : showDialog(
                    context: context,
                    builder: (context)
                    {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('something went wrong!'),
                      );
                    }
                );
              },
                  child: Text('logout')),

            ],
          ),
        );
      },
    );

  }

  getUserDetails() async
  {
    providerState = Provider.of<ProvideState>(context,listen: false);

    print(providerState?.getUid);
    data = await providerState?.getUserName();
    if(data!= null) {
      name=data['name'];
      prevValue = data['value'];
    }
    print('data: $data');
    print('name: ${data['name']}');
    setState(() {
      _currentHorizontalIntValue = prevValue;
    });
  }

  updateDetails() async
  {
    providerState = Provider.of<ProvideState>(context,listen: false);

    Map model = {
      'value' : _currentHorizontalIntValue
    };
    print(model);
    print(providerState?.getUid);
    var val = await providerState?.updateUserData(providerState?.getUid, model);
    isUpdated = val;
    print('val: $isUpdated');


  }
}
