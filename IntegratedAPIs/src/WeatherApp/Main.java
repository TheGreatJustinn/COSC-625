package WeatherApp;

public class Main {
    public static void main(String[] args) {
        
        String zipCode = "10001";
        GeonameAPI.Coordinates coordinates = GeonameAPI.getCoordinates(zipCode);
        
        if (coordinates != null) {
            System.out.println("Latitude: " + coordinates.getLatitude());
            System.out.println("Longitude: " + coordinates.getLongitude());

            
            String forecast = NWSapi.getForecast(String.valueOf(coordinates.getLatitude()), String.valueOf(coordinates.getLongitude()));
            if (forecast != null) {
            	//Uncomment to view raw data
            	//System.out.println("Raw Hourly Forecast Data: " + hourlyForecast);
                
                String parsedForecast = NWSForecastParser.parseForecast(forecast);
                
                //if you uncomment to view raw data you should comment the line below
                String hourlyForecastUrl = parsedForecast.split("Hourly Forecast URL: ")[1].split("\n")[0];

                String hourlyForecast = NWSapi.getHourlyForecast(hourlyForecastUrl);
                System.out.println("Raw Hourly Forecast Data: " + hourlyForecast);

                
            } else {
                System.out.println("Failed to retrieve forecast.");
            }
        } else {
            System.out.println("Coordinates not found.");
        }
    }
}
