import 'package:http/http.dart' as http;
import 'package:weather_app/api/endpoints.dart';
import 'dart:async';
import 'dart:convert';
import 'package:weather_app/constants/constants.dart';

class WeatherApi {

  Future getCurrentWeather(String city) async {
    final response = await _makeGetRequest(Endpoints.getCurrentWeather(city));
    return json.decode(response.body);
  }

  Future findCities(String query) async {
    final http.Response response = await _makeGetRequest(Endpoints.getCitiesList(query));
    List<dynamic> citiesList = await json.decode(response.body);
    return _getCitiesNamesList(citiesList, query);
  }

  List<String> _getCitiesNamesList(List<dynamic> citiesList, String query){
    citiesList = _filterCities(citiesList, query);
    if (citiesList.isEmpty) {
      return List<String>.empty();
    }
    return List<String>.generate(citiesList.length, (index) => citiesList.elementAt(index)[CityObjectAccessors.NAME]);
  }

  Future _makeGetRequest(Uri url) async {
    return await http.get(url);
  }

  List<dynamic> _filterCities(List<dynamic> citiesList, String query){
    return citiesList.where((element) {
      return element[CityObjectAccessors.NAME].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

