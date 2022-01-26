class Sdwob {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  List<Daily>? daily;

  Sdwob(
      {this.lat, this.lon, this.timezone, this.timezoneOffset, this.daily});

  Sdwob.fromJson(Map<String, dynamic> json) {
	List<dynamic> DyList = json["daily"];
    List<Daily> DaList = DyList.map((val) => Daily.fromJson(val)).toList();
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
	  daily = DaList;
  }
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  num? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  num? windGust;
  List<Weather>? weather;
  int? clouds;
  num? pop;
  num? uvi;
  double? rain;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi,
      this.rain});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
	
    temp = Temp.fromJson(json['temp']);
	  feelsLike = FeelsLike.fromJson(json['feels_like']);
	
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
	
	  List<dynamic> DyList = json['weather'];
	  List<Weather> WList = DyList.map((e) => Weather.fromJson(e)).toList();
    weather = WList;
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
    rain = json['rain'];
  }

}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}
