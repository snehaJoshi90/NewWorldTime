import 'package:demo_project/models/list_data.dart';
import 'package:flutter/material.dart';


 class UserDetails extends StatefulWidget {


   @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  Map data={};
   @override
   Widget build(BuildContext context) {

     data=data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map;

      print(data);



     return Scaffold(
       appBar: AppBar(
         title: Text('User Details',style: Theme.of(context).textTheme.displayLarge,),
         backgroundColor: Colors.yellow,
           centerTitle: true,
           leading:
             IconButton(
                 onPressed:(){
                  // Navigator.pushReplacementNamed(context, '/screen_bottombar');
                   Navigator.pop(context);
         },
                 icon: Icon(Icons.arrow_back))

       ),
       body:
          Padding(
             padding: const EdgeInsets.fromLTRB(60.0, 20.0, 30.0, 8.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 CircleAvatar(
                   child:ClipOval (
                       //borderRadius: new BorderRadius.circular(100.0),
                       child: Image.network(data['avatar']??'',
                           width: 300,
                           height: 300,
                           fit: BoxFit.cover,

                       ),

                   ),
                 radius: 80,
                   backgroundColor: Colors.grey[50],
                 ),
                 SizedBox(height: 20.0,),
                 Text(data['first_name'],
                     style: TextStyle(
                     fontSize: 28.0,letterSpacing: 2.0,fontWeight: FontWeight.bold)),
                 SizedBox(height: 20.0,),
                 Text(data['last_name'],
                     style: TextStyle(
                         fontSize: 28.0,letterSpacing: 2.0,fontWeight: FontWeight.bold)),
                 SizedBox(height: 20.0,),
                 Text(data['email'],
                     style: TextStyle(
                     fontSize: 20.0,letterSpacing: 2.0)),

               ],
             ),
             ),


     );
   }
}
