import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  
 Future <void> ShowSplashScreen()async{

    Timer(Duration(seconds: 3),() async{
      if(!mounted)return;
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences _prefs=await SharedPreferences.getInstance();
      var  status=_prefs.getBool('isLoggedIn');
      if(status==true){
        Navigator.pushReplacementNamed(context, '/screen_bottombar');
        print(status);
        }
      else{
    Navigator.pushReplacementNamed(context, '/screen_login');
    print(status);
    }

    });
  }

  @override
  void initState() {
    super.initState();
    ShowSplashScreen();
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
