

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather/ob/wob.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  WOb? wOb;
  String wWMain = '';
  String wWIcon = '';
  String wName='';
  String appID = "08296dc9a1f645bd848bfe5248cf2337";
  String baseUrl = "http://api.openweathermap.org/data/2.5/weather";
  
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  getLocation()async{
    _serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled!) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled!) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();
print(_locationData!.latitude);
print(_locationData!.longitude); 
double lat = _locationData!.latitude!;
double lon = _locationData!.longitude!;


var response = await http.get(Uri.parse(baseUrl+"?lat=$lat&lon=$lon&appid=$appID"));
print(response.statusCode);
print(response.body);

  if(response.statusCode==200){
    setState(() {
      wOb = WOb.fromJson(jsonDecode(response.body));
      print(wOb!.name);
      print(wOb!.weather![0].main!);
      print(wOb!.weather![0].icon!);
      wName = wOb!.name!;
      wWMain = wOb!.weather![0].main!;
      wWIcon = wOb!.weather![0].icon!;


      
    });
  }
  else{
    print('Error');
  }

  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Weater Forecast'),
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
            top: 50,
            left: 30,
            child: Text(
             wName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ) 
          ),

          Positioned(
            top: 80,
            left: 30,
            child: Text(
              DateFormat('EEEE, d/MMM/y').format(DateTime.now()),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              )
          ),

          Positioned(
            top: 110,
            left: 30,
            child: Text(
              DateFormat().add_jm().format(DateTime.now()),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              )
          ),

          Positioned(
            bottom: 60,
            right: 30,
            child: Text(
              wWMain,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              )
          ),

          Positioned(
            bottom: 90,
            right: 30,
            child: Text(
              wWIcon,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              )
          ),

        ],
      )
    );
  }
}

