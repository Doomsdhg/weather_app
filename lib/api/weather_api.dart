import 'package:http/http.dart' as http;
import 'package:weather_app/api/endpoints.dart';
import 'dart:async';
import 'dart:convert';
import 'package:weather_app/constants/constants.dart';

class WeatherApi extends WebService {

  Future getCurrentTemperature(String city) async {
    final response = await _makeGetRequest(await Endpoints.getCurrentWeather(city));
    final decodedBody = await json.decode(response.body);
    return decodedBody[WeatherAccessors.CURRENT][WeatherAccessors.CELCIUS_TEMPERATURE];
  }

  Future getCurrentWeather(String city) async {
    final response = await _makeGetRequest(await Endpoints.getCurrentWeather(city));
    final decodedBody = await json.decode(response.body);
    return decodedBody[WeatherAccessors.CURRENT];
  }

  Future getForecast({required String city, required String days}) async {
    final response = await _makeGetRequest(await Endpoints.getForecastWeather(city: city, days: days));
    final decodedBody = await json.decode(response.body);
    return decodedBody;
  }

  Future findCities(String query) async {
    final http.Response response = await _makeGetRequest(await Endpoints.getCitiesList(query));
    final citiesList = await json.decode(response.body);
    return _getCitiesNamesList(citiesList: citiesList, query: query);
  }

  Future getLocation(String city) async {
    final response = await _makeGetRequest(await Endpoints.getCurrentWeather(city));
    final decodedBody = await json.decode(response.body);
    return decodedBody[LocationAcessors.LOCATION];
  }

  List<String> _getCitiesNamesList({
    required List<dynamic> citiesList,
    required String query
  }){
    citiesList = _filterCities(citiesList: citiesList, query: query);
    if (citiesList.isEmpty) {
      return List<String>.empty();
    }
    return List<String>.generate(citiesList.length, (index) => citiesList.elementAt(index)[CityObjectAccessors.NAME]);
  }

  List<dynamic> _filterCities({
    required List<dynamic> citiesList,
    required String query
  }){
    return citiesList.where((element) {
      return element[CityObjectAccessors.NAME].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

abstract class WebService {
  Future _makeGetRequest(Uri url) async {
    return await http.get(url);
  }
}
