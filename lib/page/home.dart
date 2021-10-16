

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String appID = "08296dc9a1f645bd848bfe5248cf2337";
  String baseUrl = "api.openweathermap.org/data/2.5/weather";
  
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

var response = await http.get(Uri.parse(baseUrl+"?lat=$lat & lon=$lon & appid=$appID"));
print(response.statusCode);
print(response.body);

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
    );
  }
}

