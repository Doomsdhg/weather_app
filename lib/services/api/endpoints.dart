import 'package:weather_app/services/api/crypting_manager.dart';

class Endpoints {

  static String _baseUrl = 'https://api.weatherapi.com/v1/';

  static String _currentWeatherBaseUrl = '$_baseUrl' + 'current.json?key=';

  static String _searchBaseUrl = '$_baseUrl' + 'search.json?key=';

  static String _forecastUrl = '$_baseUrl' + 'forecast.json?key=';

  static Future<String> _getApiKey() async {
    return await CryptingManager().getApiKey();
  }

  static Future<Uri> getCurrentWeather(String city) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_currentWeatherBaseUrl$apiKey&q=$city&aqi=no');
  }

  static Future<Uri> getCitiesList(String query) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_searchBaseUrl$apiKey&q=$query');
  }

  static Future<Uri> getForecastWeather({required String city, required String days}) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_forecastUrl$apiKey&q=$city&days=$days&aqi=no&alerts=no');
  }
}