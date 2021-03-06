import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; //
  String flag; // url to the flag image
  String url; // what we tack on to the end of the url
  bool isDayTime; // true or false if it's daytime

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      //set the time property
      time =  DateFormat.jm().format(now);
    }
    catch(e) {
      print('Caught error $e');
      time = 'could not get time data';
    }




  }

}


