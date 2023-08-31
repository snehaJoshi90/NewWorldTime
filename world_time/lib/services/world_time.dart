import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({ this.location,this.flag,this.url});


  Future<String> getTime() async{
    try{
      Response response=  await
      get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
    Map data=jsonDecode(response.body);

    //get properties from data
    String datetime=data['datetime'];
    String offset=data['utc_offset'].substring(1,3);
    //print(datetime);
   // print(offset);

    //create dateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDaytime=now.hour> 6 && now.hour<20?true:false;
    time=DateFormat.jm().format(now);
return time ?? '';
    }
    catch(e){
      print('Cought error $e');
      time='Could not get time date';
    }
return '';

  }

}


