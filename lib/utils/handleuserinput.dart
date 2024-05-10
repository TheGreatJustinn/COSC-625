import 'api.dart';

class HandleUserInput {
  static String? storedZipCode;
  static bool isCelsius = false;

  static void handleQuery(String query, bool isCelsius) {
    storedZipCode = query;
    HandleUserInput.isCelsius = isCelsius;

    print('Stored ZIP Code: $storedZipCode');
    print('Temperature Unit: ${isCelsius ? 'Celsius' : 'Fahrenheit'}');

    if (storedZipCode != null) {
      WeatherApi.getWeatherData(storedZipCode!, isCelsius);
    }
  }
}