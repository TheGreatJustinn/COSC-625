package WeatherApp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GeonameAPI {

    public static Coordinates getCoordinates(String zipCode) {
        try {
            String country = "US";
            String apiUrl = "https://www.geonames.org/postalcode-search.html?q=" + zipCode + "&country=" + country;

            URL url = new URL(apiUrl);

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            Coordinates coordinates = extractCoordinates(response.toString());
            if (coordinates != null) {
                return coordinates;
            } else {
                return new Coordinates(0, 0); // Default coordinates if not found
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static Coordinates extractCoordinates(String html) {

        Pattern pattern = Pattern.compile("<a[^>]*>\\s*<small>\\s*([0-9.-]+)\\s*/\\s*([0-9.-]+)\\s*</small>\\s*</a>");
        Matcher matcher = pattern.matcher(html);
        if (matcher.find()) {
            double latitude = Double.parseDouble(matcher.group(1));
            double longitude = Double.parseDouble(matcher.group(2));
            return new Coordinates(latitude, longitude);
        }
        return null;
    }

    public static class Coordinates {
        private double latitude;
        private double longitude;

        public Coordinates(double latitude, double longitude) {
            this.latitude = latitude;
            this.longitude = longitude;
        }

        public double getLatitude() {
            return latitude;
        }

        public double getLongitude() {
            return longitude;
        }
    }
}
