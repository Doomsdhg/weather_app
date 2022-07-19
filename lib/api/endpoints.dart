class Endpoints {

  static String _baseUrl = 'https://api.weatherapi.com/v1/';

  static String _apiKey = '403731c81f42492286f114115221807';

  static String _currentWeatherBaseUrl = '$_baseUrl' + 'current.json?key=';

  static String _searchBaseUrl = '$_baseUrl' + 'search.json?key=';

  static Uri getCurrentWeather(String city){
    return Uri.parse('$_currentWeatherBaseUrl$_apiKey&q=$city' + '&aqi=no');
  }

  static Uri getCitiesList(String query){
    return Uri.parse('$_searchBaseUrl$_apiKey&q=$query');
  }
}