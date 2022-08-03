class AssetsPaths {
  static String API_KEY = 'packages/weather_app/assets/api_key.json';
}

class ApiKeyObjectAccessors {
  static String SECRET_KEY = "secretKey";
  static String ENCRYPTED_API_KEY = "encryptedApiKey";
  static String INITIAL_VECTOR = "iv";
}

class CityObjectAccessors {
  static String NAME = "name";
}

class WeatherAccessors {
  static String CURRENT = "current";
  static String CELCIUS_TEMPERATURE = "temp_c";
  static String FORECAST = "forecast";
  static String FORECAST_DAY = "forecastday";
}

class ForecastAccessors {
  static String HOUR = "hour";
}

class LocationAcessors {
  static String LOCATION = "location";
  static String CITY_NAME = "name";
  static String COUNTRY = "country";
  static String LOCAL_TIME = "localtime";
}

class ConditionAccessors {
  static String CONDITION = "condition";
  static String ICON = "icon";
  static String TEXT = "text";
}

class DateTimeAccessors {
  static String TIME = "time";
}

class UrlConstants {
  static String HTTPS_PROTOCOL = "https:";
}

class TimeConstants {
  static String EXACTLY_HOUR = ":00";
}

class TemperatureConstants {
  static String CELCIUS = "°C";
}

class FontConstants {
  static double SMALL_SIZE = 18;
  static double MIDDLE_SIZE = 25;
  static double LARGE_SIZE = 35;
}

class ForecastLengthConstants {
  static String ONE_DAY = "1";
  static String TWO_DAYS = "2";
  static String THREE_DAYS = "3";
}