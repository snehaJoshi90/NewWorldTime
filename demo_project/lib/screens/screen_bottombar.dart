import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_project/screens/screen_list.dart';
import 'package:demo_project/screens/screen_profile.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex=0;
  static const List<Widget> _widgetOPtions=<Widget>[
     MyList(),
    EditProfile()
  ];

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs?.clear();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/screen_login');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: _widgetOPtions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label:'List',
            backgroundColor: Colors.yellow),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label:'Edit Profile',
              backgroundColor: Colors.yellow),
        ],
        type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
           onTap: (int index){
          switch(index){
            case 0:
              MyList();
            case 1:
              EditProfile();
          }
          setState(() {
            _selectedIndex=index;
          });
           },
            elevation: 5 ,
      ),
    );
  }
}
