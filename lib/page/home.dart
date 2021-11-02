
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather/constant/constant.dart';
import 'package:weather/page/dailyforecast.dart';
import 'package:weather/ob/wob.dart';
import 'package:weather/page/forcity.dart';


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
  double? lat;
  double? lon;

  
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
lat = _locationData!.latitude!;
lon = _locationData!.longitude!;


var response = await http.get(Uri.parse(baseUrl+"?lat=$lat&lon=$lon&appid=$appID&units=metric"));
print(response.statusCode);
// print(response.body);

  if(response.statusCode==200){
    setState(() {
      wOb = WOb.fromJson(jsonDecode(response.body));
      print(wOb!.name);
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
      body: wOb == null? 
      Container(
        child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
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
      :Stack(
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
             wOb == null ? '' : wOb!.name!,
              style: const TextStyle(
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
              style: const TextStyle(
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              )
          ),

          Positioned(
            top: 140,
            left: 30,
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return DailyForecast(lat!, lon!);
                  })
                );
              },
              child: const Text(
                '7 Days Forecast',
                style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
                )
              )
          ),

          Positioned(
            bottom: 60,
            right: 30,
            child: Row(
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.network("http://openweathermap.org/img/wn/${wOb!.weather![0].icon!}@2x.png")),
                Text(
                  wOb == null ? '' : wOb!.weather![0].main!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
              ],
            )
          ),

          Positioned(
            bottom: 120,
            right: 30,
            child: Text(
             wOb == null ? '' : wOb!.main!.temp.toString()+ " C",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ) 
          ),

          Positioned(
            top: 38,
            right: 30,
            child: IconButton(
              color: Colors.white,
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return const ForCity();
                  })
                );
              }, 
              icon: const Icon(Icons.location_city_sharp)
            )
          ),


        ],
      )
    );
  }
}

