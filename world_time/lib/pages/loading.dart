import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time='loading';


  void _setupWorldTime() async{
    WorldTime instance=WorldTime(location: 'Mumbai',flag: 'india.png',url: 'Asia/Kolkata');
      await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments:{
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
    'isDaytime':instance.isDaytime} );
  }


  @override
  void initState(){
    _setupWorldTime();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
     body: Center(
   //    child: CircularProgressIndicator(),
     ),
    );
  }
}
