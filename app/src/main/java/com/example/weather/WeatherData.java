package com.example.weather;

public class WeatherData {
    private String name;
    private int temperature;
    private String temperatureUnit;
    private int relativeHumidity;
    private String windSpeed;
    private String windDirection;
    private String shortForecast;

    // Constructor
    public WeatherData(String name, int temperature, String temperatureUnit, int relativeHumidity,
                       String windSpeed, String windDirection, String shortForecast) {
        this.name = name;
        this.temperature = temperature;
        this.temperatureUnit = temperatureUnit;
        this.relativeHumidity = relativeHumidity;
        this.windSpeed = windSpeed;
        this.windDirection = windDirection;
        this.shortForecast = shortForecast;
    }

    // Getters
    public String getName() {
        return name;
    }

    public int getTemperature() {
        return temperature;
    }

    public String getTemperatureUnit() {
        return temperatureUnit;
    }

    public int getRelativeHumidity() {
        return relativeHumidity;
    }

    public String getWindSpeed() {
        return windSpeed;
    }

    public String getWindDirection() {
        return windDirection;
    }

    public String getShortForecast() {
        return shortForecast;
    }
}