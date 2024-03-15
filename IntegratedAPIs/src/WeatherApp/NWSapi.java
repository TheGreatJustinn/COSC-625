package WeatherApp;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class NWSapi {
    public static String getForecast(String latitude, String longitude) {
        String responseBody = null;

        try {
            String apiUrl = String.format("https://api.weather.gov/points/%s,%s", latitude, longitude);

            HttpClient client = HttpClient.newHttpClient();

            URI apiUri = URI.create(apiUrl);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(apiUri)
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("Status Code: " + response.statusCode());
            System.out.println("Raw Forecast Data:\n" + response.body());
            
            responseBody = response.body();

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        return responseBody;
    }
    
    public static String getHourlyForecast(String hourlyForecastUrl) {
        String responseBody = null;

        try {
            HttpClient client = HttpClient.newHttpClient();

            URI hourlyForecastUri = URI.create(hourlyForecastUrl);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(hourlyForecastUri)
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("Status Code: " + response.statusCode());
            System.out.println("Raw Hourly Forecast Data:\n" + response.body());
            
            responseBody = response.body();

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        return responseBody;
    }
}
