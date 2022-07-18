class Endpoints {

  static String _baseUrl = 'https://api.weatherapi.com/v1/current.json?key=';

  static String _apiKey = '403731c81f42492286f114115221807';

  static Uri getCurrentWeather(String city){
    return Uri.parse('$_baseUrl$_apiKey&q=$city&aqi=no');
  }
}