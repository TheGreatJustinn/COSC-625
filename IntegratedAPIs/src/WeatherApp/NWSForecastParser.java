package WeatherApp;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NWSForecastParser {

    public static String parseForecast(String rawData) {
        StringBuilder forecastBuilder = new StringBuilder();
        forecastBuilder.append("Forecast Details:\n");

        Pattern forecastPattern = Pattern.compile("\"forecast\": \"([^\"]+)\"");
        Matcher forecastMatcher = forecastPattern.matcher(rawData);

        if (forecastMatcher.find()) {
            String forecastUrl = forecastMatcher.group(1);
            forecastBuilder.append("Forecast URL: ").append(forecastUrl).append("\n");
        } else {
            return "Error parsing forecast URL.";
        }

        Pattern hourlyForecastPattern = Pattern.compile("\"forecastHourly\": \"([^\"]+)\"");
        Matcher hourlyForecastMatcher = hourlyForecastPattern.matcher(rawData);

        if (hourlyForecastMatcher.find()) {
            String hourlyForecastUrl = hourlyForecastMatcher.group(1);
            forecastBuilder.append("Hourly Forecast URL: ").append(hourlyForecastUrl).append("\n");
        } else {
            return "Error parsing hourly forecast URL.";
        }

        return forecastBuilder.toString();
    }
}
