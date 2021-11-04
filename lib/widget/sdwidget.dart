import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/ob/sdwob.dart';

// ignore: must_be_immutable
class Sdwidget extends StatelessWidget {
  Daily daily;
  Sdwidget(this.daily, { Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(
          context: context, 
          builder: (context){
            return AlertDialog(
              title: Text(DateFormat("EEEE, dd-MMM").format(DateTime.fromMillisecondsSinceEpoch(daily.dt!*1000))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Day_Temp = ${daily.temp!.day!.toString()}"" C"),
                  Text("Night_Temp = ${daily.temp!.night!} C"),
                  Text(daily.weather![0].main!),
                  Text(daily.weather![0].description!),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: const Text('Cancel')
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: const Text('Back')
                ),
              ],
            );
          }
        );
      },
      child: Card(
        color: Colors.indigo,
        child: ListTile(
          leading: Image.network("http://openweathermap.org/img/wn/${daily.weather![0].icon!}@2x.png"),
          title: Text(daily.weather![0].main!),
          subtitle: Text(DateFormat("EEE dd-MMM-y").format(DateTime.fromMillisecondsSinceEpoch(daily.dt!*1000))),
        ),
      ),
    );
  }
}