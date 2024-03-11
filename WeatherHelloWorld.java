import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class WeatherHelloWorld {

    public static void main(String[] args) {
        String latitude = "39.6581";
        String longitude = "-78.9284";

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

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
