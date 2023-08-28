import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/screens/screen_login.dart';
import 'package:demo_project/screens/screen_signup.dart';
import 'package:demo_project/screens/screen_list.dart';
import 'package:demo_project/screens/screen_splash.dart';
import 'package:demo_project/screens/screen_details.dart';
import 'package:demo_project/screens/screen_bottombar.dart';
import 'package:demo_project/screens/screen_profile.dart';
import 'package:demo_project/common/theme.dart';
import 'package:demo_project/models/list_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreference();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>listProvider(),
     child:MaterialApp(
      title: 'Project Demo',
      theme: appTheme,

      initialRoute: '/screen_splash',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>SplashScreen(),
        '/screen_login':(context)=>MyLogin(),
        '/screen_signup':(context)=>MysignUp(),
        '/screen_list':(context)=>MyList(),
        '/screen_details':(context)=>  UserDetails(),
        '/screen_bottombar':(context)=> MyNavigationBar(),
        '/screen_profile':(context)=> EditProfile(),
      },
      


    ),
    );
  }
}



