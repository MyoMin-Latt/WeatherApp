import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/constant/constant.dart';
import 'package:weather/ob/wob.dart';
import 'package:http/http.dart' as http;

class ForCity extends StatefulWidget {
  const ForCity({ Key? key }) : super(key: key);

  @override
  _ForCityState createState() => _ForCityState();
}

class _ForCityState extends State<ForCity> {


  WOb? wOb;
  String wIcon='';
  TextEditingController _cityText = TextEditingController();
  bool isLoading = false;
  String? error;


  getData(String cityName)async{
    setState(() {
      isLoading = true;
    });
    var response = await http.get(Uri.parse(baseUrl+"?q=$cityName&appid=$appID&units=metric"));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      setState(() {
        error = null;
        isLoading = false;
        wOb = WOb.fromJson(jsonDecode(response.body));
        print(wOb!.name!);
        wIcon = wOb!.weather![0].icon!;
        print(wIcon);
      });
    }
    else{
      setState(() {
        isLoading = false;
        error = "Please check city name";
      });
      print("Error");
    }
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Weater Forecast By City'),
      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(            
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
              top: 1,
              left: 8,
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white
                            ),
                            controller: _cityText,
                            decoration: const InputDecoration(
                              labelText: 'Search By City',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                            ),
                          )
                        ),                  
                        IconButton(
                          onPressed: (){
                            getData(_cityText.text);
                          }, 
                          icon: const Icon( Icons.search)
                        ),
                      ],
                    ),
                  ),


                ],
              )
            ),


            Positioned(
            top: 70,
            left: 5,
            child: 
            isLoading? const Center(
              child: CircularProgressIndicator(color: Colors.white,),
            ):
            error!=null? 
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Text(error!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            )
            :wOb == null? Container() 
            :Column(
              children: [
                Row(
                  children: [
                    Image.network("http://openweathermap.org/img/wn/${wOb!.weather![0].icon!}@2x.png"),                
                    Text(
                      wOb!.weather![0].main!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Text(
                  'Temperature = '+ wOb!.main!.temp.toString() + ' C',
                  style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Pressure = ' + wOb!.main!.pressure.toString(),
                  style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Humidity =' + wOb!.main!.huminity.toString(),
                  style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                ),
              ],
            )
          ),
            

            

            
          ],
        ),
      ),
    );
  }
}