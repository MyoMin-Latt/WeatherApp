import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/constant/constant.dart';
import 'package:weather/ob/sdwob.dart';
import 'package:weather/widget/sdwidget.dart';

// ignore: must_be_immutable
class DailyForecast extends StatefulWidget {
  double lat;
  double lon;
  DailyForecast(this.lat, this.lon, { Key? key }) : super(key: key);  

  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {

  Sdwob? sdwob;
  bool isLoading = true;

  getData()async{
    // print(SEVENDAYURL+"?lat=${widget.lat}&lon=${widget.lon}&exclude=current,minutely,hourly,alerts&appid=$appID");
    var response = await http.get(Uri.parse(SEVENDAYURL+"?lat=${widget.lat}&lon=${widget.lon}&exclude=current,minutely,hourly,alerts&appid=$appID&units=metric"));
    print(response.statusCode);
    // print(response.body);
    if(response.statusCode==200){
      setState(() {
        isLoading = false;
        sdwob = Sdwob.fromJson(jsonDecode(response.body));
        print(sdwob!.lat!.toString());
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
      print('Error');
    }
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


          sdwob==null ? const Center(child: CircularProgressIndicator(color: Colors.white,),)
          :Positioned(
            top: 10,
            bottom: 0,
            left: 0,
            right: 0,
            child: isLoading? Container() :ListView.builder(
              itemCount: sdwob!.daily!.length,
              itemBuilder: (context, index){
                return Sdwidget(sdwob!.daily![index]);
              }
            )
          ),

        ],
      ),
    );
  }
}
