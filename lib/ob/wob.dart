
class WOb {
  String? name;
  List<Weather>? weather;

  WOb({
    this.name,
    this.weather,
    });
    WOb.fromJson(Map<String, dynamic> json){
      List<dynamic> wlist = json["weather"];
      List<Weather> wObList = wlist.map((e) => Weather.fromJson(e)).toList();
      
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