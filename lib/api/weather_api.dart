import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api/endpoints.dart';

class WeatherApi extends WebService {

  Future getCurrentWeather(String city) async {
    final response = await _makeGetRequest(await Endpoints.getCurrentWeather(city));
    return json.decode(response.body);
  }
}

abstract class WebService {
  Future _makeGetRequest(Uri url) async {
    return await http.get(url);
  }
}