import 'package:flutter/material.dart';
import 'package:demo_project/screens/screen_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();





  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    final userDetails = await UserPreference.getUserDetails();
    nameController.text = userDetails['username']!;
    emailController.text = userDetails['email']!;
    passwordController.text = userDetails['password']!;
    dobController.text=userDetails['date_of_birth']!;

  }


  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Edit Profile',style: Theme.of(context).textTheme.displayLarge,),
          backgroundColor: Colors.yellow, centerTitle: true,


        ),

        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                        controller: nameController,
                         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                         decoration: InputDecoration( icon: Icon(Icons.account_circle_rounded),labelText: 'User Name',labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                        ),
                        const SizedBox(height: 24,),
                        TextField(
                          controller: emailController,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          decoration: InputDecoration( icon: Icon(Icons.email),labelText: 'Email',labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),),
                        const SizedBox(height: 24,),
                        TextField(
                          controller: dobController,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(labelText: 'Date of Birth',labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                               icon: Icon(Icons.calendar_today),
                           ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:DateTime.parse(dobController.text),
                                firstDate:DateTime(1901), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              print(pickedDate);
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);


                              setState(() {
                                dobController.text = formattedDate;
                             //  String date_of_birth=formattedDate;
                              });
                            }
                          },
                        ),


                        const SizedBox(height: 24,),
                        TextField(
                          controller: passwordController,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          decoration: InputDecoration( icon: Icon(Icons.lock),labelText: 'Password'
                              ,labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                              suffixIcon:   GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child:
                                new Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                              )
                          ),
                          obscureText: _obscureText,
                          ),
                        const SizedBox(height: 24,),


                        ElevatedButton(
                        onPressed: () async {
                        final username = nameController.text;
                        final email = emailController.text;
                        final date_of_birth =dobController.text;
                        final password=passwordController.text;
                        await UserPreference.saveUserDetails( email,password,username,date_of_birth);
                          print(email);
                          print(password);
                          print(username);
                          print(date_of_birth);

                         // Navigator.pushReplacementNamed(context, '/screen_login');
                        final snackBar = SnackBar(
                          content: const Text('Successfully saved'),);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print('Successfully saved');

                          },
                           style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                           child: Text('Save',style: Theme.of(context).textTheme.titleLarge,),
                ),
               ],
          ),
          ),
        )

    );
  }
}
