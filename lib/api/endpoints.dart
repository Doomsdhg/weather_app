import 'package:weather_app/api/crypting_manager.dart';

class Endpoints {

  static String _baseUrl = 'https://api.weatherapi.com/v1/current.json?key=';

  static String _currentWeatherBaseUrl = '$_baseUrl' + 'current.json?key=';

  static String _searchBaseUrl = '$_baseUrl' + 'search.json?key=';

  static Future<String> _getApiKey() async {
    return await CryptingManager().getApiKey();
  }

  static Future<Uri> getCurrentWeather(String city) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_currentWeatherBaseUrl$apiKey&q=$city&aqi=no');
  }

  static Uri getCitiesList(String query) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_searchBaseUrl$apiKey&q=$query');
  }
}