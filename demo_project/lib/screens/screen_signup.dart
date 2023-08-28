import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{
 static const String _keyEmail='email';
 static const String _keyPassword='password';
 static const String _keyUserName='username';
 static const String _keyDOB='date_of_birth';

  static Future<bool> saveUserDetails(String email,String password,String username,String date_of_birth)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyEmail,email) &&
        await prefs.setString(_keyPassword,password)&&
        await prefs.setString(_keyUserName,username)&&
        await prefs.setString(_keyDOB,date_of_birth);


  }

  static Future<Map<String,String>> getUserDetails()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? email=prefs.getString(_keyEmail);
    String? password=prefs.getString(_keyPassword);
    String? username=prefs.getString(_keyUserName);
    String? date_of_birth=prefs.getString(_keyDOB);
    await prefs.setBool('isLoggedIn', true);
    return{ 'email':email ?? '' , 'password':password ?? '','username':username??'','date_of_birth':date_of_birth ??''};
  }
}




class MysignUp extends StatefulWidget {
  const MysignUp({Key? key}) : super(key: key);



  @override
  State<MysignUp> createState() => _MysignUpState();
}

class _MysignUpState extends State<MysignUp> {
  TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  void saveSignupData(String email ,String password ,String username,String date_of_birth)async{
    bool success= await UserPreference.saveUserDetails(email,password,username,date_of_birth);
    if(success){
      print('Signup data saved successfully.');
    }
    else{
      print('Fail to save signup data');
    }
  }

  final _formKey = GlobalKey<FormState>();
  var confirmPass;
 String _email='';
  String _password='';
  String _username='';
  String _date_of_birth='';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          appBar: AppBar(
            title: Text('Sign Up',style: Theme.of(context).textTheme.displayLarge,),
            backgroundColor: Colors.lightBlue,
          ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(50.0),
              child:Form(

                key:_formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                 decoration: const InputDecoration(
                     icon: Icon(Icons.account_circle_rounded),
                  hintText: 'User Name'
                  ),
                    validator: (value)=>value == null || value.isEmpty?'Please enter Username':null
                  ),

                  const SizedBox(height: 24,),

                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email Id',
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty )  {
                        return "Please enter email";
                      } else if(!value.contains("@")) {
                        return "Please enter valid email";
                      }
                    },
                  ),
                  const SizedBox(height: 24,),

                  TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date of Birth"
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate:DateTime(1901), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );
                          if(pickedDate != null ){
                          print(pickedDate);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);


                          setState(() {
                          dateController.text = formattedDate;
                          _date_of_birth=formattedDate;
                                      });
                          } else{
                          print("Date is not selected");
                             }
                          },
                      ),
                        const SizedBox(height: 24,),

                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                        hintText: 'Password'
                          ),
                          obscureText: true,
                          validator: ( value) {
                         confirmPass = value;
                         if (value == null || value.isEmpty) {
                         return "Please Enter New Password";}
                         else if (value.length < 8) {
                         return "Password must be atleast 8 characters long";}
                         else {
                        return null;}
                         },
                    ),

                  const SizedBox(height: 24,),

                  TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                        hintText: 'Confirm Password'
                      ),
                    obscureText: true,
                    validator: ( value) {
                      if (value == null || value.isEmpty) {
                        return "Please Re-Enter New Password";
                      } else if (value.length < 8) {
                        return "Password must be atleast 8 characters long";
                      } else if (value != confirmPass) {
                        return "Password must be same as above";
                      } else {
                        return null;
                      }
                    },


                  ),
                  const SizedBox(height: 60,),
            SizedBox(
              height: 50,
              width:300,

             child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          saveSignupData(_email,_password,_username,_date_of_birth );
                         Navigator.pushReplacementNamed(context, '/screen_login');
                        }

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow
                      ),
                      child:  Text('Register',
                          style: Theme.of(context).textTheme.titleLarge,)
                  ),
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
