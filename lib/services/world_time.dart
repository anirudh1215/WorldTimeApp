import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time =''; // the time in that location
  String flag ; // url to an asset flag icon
  String url;
  bool? isDaytime;

  WorldTime({required this.location, required this.flag,  required this.url,});



  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get(Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data['dateTime'];
      //  print(datetime);

      DateTime now = DateTime.parse(datetime);

      // set the time property
      isDaytime = now.hour>6 && now.hour<20 ? true :false ;
      time = DateFormat.jm().format(now);


    }
    catch (e){
      print('caught error: $e');
      time = 'could not get time data';

    }

  }
}

