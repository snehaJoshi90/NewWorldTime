import 'package:flutter/material.dart';
import 'dart:async';
import 'package:demo_project/screens/screen_signup.dart';





class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();

}

class _MyLoginState extends State<MyLogin> {

  final _loginKey = GlobalKey<FormState>();


  Future<void> compareLoginData(String username, String password) async {
    Map<String,String> userDetails = await UserPreference.getUserDetails();
    String? svemail = userDetails['email'];
    String? svpassword = userDetails['password'];


    if (username == svemail && password == svpassword) {
      Navigator.pushReplacementNamed(context, '/screen_bottombar');
      //Navigator.pushReplacementNamed(context, '/screen_list');
      print('Login successful!');

    }
    else {
      final snackBar = SnackBar(
        content: const Text('Invalid login credentials!'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Invalid login credentials!');
    }
  }
  String _emailLgn='';


  String _passwordLgn='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login page',style: Theme.of(context).textTheme.displayLarge,),
          backgroundColor: Colors.lightBlue,
        ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(

            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _loginKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome',
                          style: TextStyle(color: Colors.blue,
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold),
                    ),
                const SizedBox(
                  height: 74,
                ),


                TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _emailLgn = value;
                      });
                    },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email),
                    hintText: 'Email Id',
                  ),

                    validator: (value)=>value == null || value.isEmpty?'Please enter Email Id':null
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _passwordLgn = value;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.password),
                      hintText: 'Password'
                  ),
                  obscureText: true,
                  validator: ( value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter New Password";
                    } else if (value.length < 8) {
                      return "Password must be atleast 8 characters long";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),

                SizedBox(
                  height: 50,
                  width:300,

                  child: ElevatedButton(
                    onPressed: ()async{


                      if (_loginKey.currentState!.validate()) {

                        compareLoginData(_emailLgn, _passwordLgn);

                      }

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow
                    ),
                    child:  Text('login',
                        style: Theme.of(context).textTheme.titleLarge,

                    )
                ),
                ),
                const SizedBox(
                  height: 24,
                ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                //padding: EdgeInsets.all(0.0),
                child: Text("Forgot password?",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20.0,)),
                onPressed: () {

                },

              ),

              TextButton(
               // padding: EdgeInsets.only(left: 0.0),
                child: Text("Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    )
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/screen_signup');
                },
              ),
            ],
          ),

              ],


            ),
          ),
        ),
        ),
      )
    );
  }
}

