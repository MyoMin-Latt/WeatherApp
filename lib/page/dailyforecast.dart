import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/constant/constant.dart';

// ignore: must_be_immutable
class DailyForecast extends StatefulWidget {
  double lat;
  double lon;
  DailyForecast(this.lat, this.lon, { Key? key }) : super(key: key);  

  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {

  getData()async{
    var response = await http.get(Uri.parse(SEVENDAYURL+"?lat=${widget.lat}&lon=${widget.lon}&exclude=current,minutely,hourly,alerts&appid=$appID"));
    print(response.statusCode);
    print(response.body);
    print(response.statusCode);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('7 Days Forecast'),
      ),
      body: Stack(
        children: [
          Positioned(            
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.indigo
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                )
              ),
            )
          ),


          Positioned(
            child: Text(widget.lon.toString())
          ),

        ],
      ),
    );
  }
}