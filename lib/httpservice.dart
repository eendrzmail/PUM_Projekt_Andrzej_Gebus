import 'dart:convert';
import 'dart:developer';

import 'package:weatherapp/datamodel.dart';

import 'package:http/http.dart' as http;
import 'package:weatherapp/datamodel_week.dart';

Future<Welcome> fetchWeather(String miasto) async {
  log(miasto);
  var response = await http.get(
      'http://api.openweathermap.org/data/2.5/weather?q=${miasto}&appid=2bfc3b69a1bcf2842e9da3fe79feef96&units=metric&lang=pl');
  return welcomeFromJson(response.body);
}

Future<Week> fetchWeatherWeek(String miasto) async {
  log('week_${miasto}');
  var response = await http.get(
      'http://api.openweathermap.org/data/2.5/forecast?q=${miasto}&appid=2bfc3b69a1bcf2842e9da3fe79feef96&units=metric&lang=pl');
  return weekFromJson(response.body);
}

/*
Future<WeatherData> fetchData() async {
  final response = await http.get(
      'http://api.openweathermap.org/data/2.5/weather?q=warsaw&appid=2bfc3b69a1bcf2842e9da3fe79feef96');
  //print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return WeatherData.fromJson(jsonDecode(response.body));
    return WeatherData.fromJson(jsonDecode(response.body).cast<WeatherData>());
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
*/
