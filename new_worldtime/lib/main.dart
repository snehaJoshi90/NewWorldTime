import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>WorldTime(),

    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map _data={};

  String _time='';
  //WorldTime _instance = WorldTime(location: 'Nashik',flag: 'india.png',url: 'Asia/Kolkata');

  void _setupWorldTime() async{
    // instance=WorldTime(location: 'Mumbai',flag: 'india.png',url: 'Asia/Kolkata');
  // _time= await _instance.getTime();
    //setState(() {

    //});
   print(_time);

  }

  @override
  void initState(){
    //_setupWorldTime();
    super.initState();
    Provider.of<WorldTime>(context,listen: false).getTime(location: 'Asia/Kolkata');
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WorldTime>(context,listen: false).getTime();
    });*/
  }

  @override
  Widget build(BuildContext context) {

    //data=ModalRoute.of(context).settings.arguments;

    return Scaffold(
    body: Consumer<WorldTime>(
      builder:(context,value,child){
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
                children: [
                  TextButton.icon(
                    onPressed: (){
                    },
                    icon: Icon(Icons.edit_location,
                      color: Colors.black,),
                    label: Text('Edit Location',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text( value.timezone ?? '-',

                        style: TextStyle(
                            fontSize: 28.0,letterSpacing: 2.0)
                        ,)
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(value.time ?? '',
                    style: TextStyle(
                        fontSize: 66.0
                    ),
                  ),
                ]
            ),
          ),
        );
      },
    ),

    );


  }

}

class WorldTime  extends ChangeNotifier  {

String? location;
String? time;
String? timezone;


WorldTime({ this.location});


Future<String> getTime({required String location}) async{
  try{
    Response response=  await
    get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$location'));
    Map data=jsonDecode(response.body);

    //get properties from data
    String datetime=data['datetime'];
    timezone=data['timezone'];
    String offset=data['utc_offset'].substring(1,3);
    print(datetime);
    print(offset);

    //create dateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    //isDaytime=now.hour> 6 && now.hour<20?true:false;
    time=DateFormat.jm().format(now);
notifyListeners();

    return time ?? '';
  }
  catch(e){
    print('Cought error $e');
    time='Could not get time date';
  }
  return '';

}

}










