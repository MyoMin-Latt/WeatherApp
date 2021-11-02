
class WOb {
  String? name;
  List<Weather>? weather;
  Main? main;

  WOb({
    this.name,
    this.weather,
    });
    WOb.fromJson(Map<String, dynamic> json){
      List<dynamic> wlist = json["weather"];
      List<Weather> wObList = wlist.map((e) => Weather.fromJson(e)).toList();
      
      main = Main.fromJson(json["main"]);
      name = json["name"];
      weather = wObList;

    }
}


class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;
  
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json){
    id = json["id"];
    main = json["main"];
    description = json["description"];
    icon = json["icon"];

  }
}

class Main{
  num? temp, feelslike, tempmin, tempmax, pressure, huminity;

  Main.fromJson(Map<String, dynamic> json){
    temp = json["temp"];
    feelslike = json["feels_like"];
    tempmin = json["temp_min"];
    tempmax = json["temp_max"];
    pressure = json["pressure"];
    huminity = json["huminity"];

  }
}