import 'package:weather_app/api/crypting_manager.dart';

class Endpoints {

  static String _baseUrl = 'https://api.weatherapi.com/v1/current.json?key=';

  static Future<String> _getApiKey() async {
    return await CryptingManager().getApiKey();
  }

  static Future<Uri> getCurrentWeather(String city) async {
    String apiKey = await _getApiKey();
    return Uri.parse('$_baseUrl$apiKey&q=$city&aqi=no');
  }
}
