import 'package:http/http.dart' as http;
import 'package:weather_app/api/endpoints.dart';
import 'dart:async';
import 'dart:convert';

class WeatherApi {

  Future getCurrentWeather(String city) async {
    final response = await _makeGetRequest(Endpoints.getCurrentWeather(city));
    return json.decode(response.body);
  }

  Future findCities(String query) async {
    final http.Response response = await _makeGetRequest(Endpoints.getCitiesList(query));
    List<dynamic> citiesList = json.decode(response.body);
    return getCitiesNamesList(citiesList, query);
  }

  Future _makeGetRequest(Uri url) async {
    return await http.get(url);
  }

  List<String> getCitiesNamesList(List<dynamic> citiesList, String query){
    citiesList = citiesList.where((element) {
      return element["name"].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
    if (citiesList.isEmpty) {
      return List<String>.empty();
    }
    return List<String>.generate(citiesList.length, (index) => citiesList.elementAt(index)["name"]);
  }
}

