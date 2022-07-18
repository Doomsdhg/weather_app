import 'package:http/http.dart' as http;
import 'package:weather_app/api/endpoints.dart';
import 'dart:async';
import 'dart:convert';

class WeatherApi {

  Future getCurrentWeather(String city) async {
    final response = await _makeGetRequest(Endpoints.getCurrentWeather(city));
    return json.decode(response);
  }

  Future _makeGetRequest(Uri url) async {
    return await http.get(url);
  }
}