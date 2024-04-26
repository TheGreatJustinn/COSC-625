String getWeatherAnimation(String? condition, String? shortForecast, bool isNighttime) {
  if (condition == null && shortForecast == null) return 'assets/sunny.json'; // default to sunny

  if (isNighttime) {
    if (condition == 'Clear' || shortForecast == 'Clear') {
      return 'assets/moon.json'; // display moon animation for clear night
    } else if (condition == 'Rain' || shortForecast == 'Rain') {
      return 'assets/moonRain.json';
    } else {
      return 'assets/moonCloud.json'; // display night clouds animation for other conditions
    }

  }

  if (condition != null) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'assets/partlycloudyday.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/mist.json';
      case 'rain':
      case 'drizzle':
        return 'assets/rainyday.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  if (shortForecast != null) {
    switch (shortForecast.toLowerCase()) {
      case 'sunny':
      case 'mostly sunny':
      case 'partly sunny':
        return 'assets/sunny.json';
      case 'cloudy':
      case 'mostly cloudy':
      case 'partly cloudy':
        return 'assets/partlycloudyday.json';
      case 'rain':
      case 'chance rain showers':
      case 'slight chance rain showers':
        return 'assets/rainyday.json';
      case 'thunderstorms':
      case 'chance showers and thunderstorms':
        return 'assets/storm.json';
      default:
        return 'assets/sunny.json';
    }
  }

  return 'assets/sunny.json'; // default to sunny if no condition or shortForecast provided
}