package com.example.weather;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity {

    private EditText editTextZipCode;
    private Button buttonGetWeather;
    private TextView textViewCityName;
    private RecyclerView recyclerViewWeather;

    private OkHttpClient client;
    private Gson gson;

    private List<WeatherData> weatherDataList;
    private WeatherAdapter weatherAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        editTextZipCode = findViewById(R.id.editTextZipCode);
        buttonGetWeather = findViewById(R.id.buttonGetWeather);
        textViewCityName = findViewById(R.id.textViewCityName);
        recyclerViewWeather = findViewById(R.id.recyclerViewWeather);

        client = new OkHttpClient();
        gson = new Gson();

        weatherDataList = new ArrayList<>();
        weatherAdapter = new WeatherAdapter(weatherDataList);

        recyclerViewWeather.setLayoutManager(new LinearLayoutManager(this));
        recyclerViewWeather.setAdapter(weatherAdapter);

        buttonGetWeather.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String zipCode = editTextZipCode.getText().toString().trim();
                if (!zipCode.isEmpty()) {
                    getWeatherData(zipCode);
                }
            }
        });
    }

    private void getWeatherData(String zipCode) {
        //api key
        String geocodingUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + zipCode + "&key=AIzaSyDALA35h_xl1wd4dQ4JWZAzn2AKMouR0IA";

        Request geocodingRequest = new Request.Builder()
                .url(geocodingUrl)
                .build();

        client.newCall(geocodingRequest).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                e.printStackTrace();
                // handle the error
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if (response.isSuccessful()) {
                    String responseData = response.body().string();
                    JsonObject jsonObject = gson.fromJson(responseData, JsonObject.class);

                    JsonArray results = jsonObject.getAsJsonArray("results");
                    if (results != null && results.size() > 0) {
                        JsonObject result = results.get(0).getAsJsonObject();
                        JsonObject location = result.getAsJsonObject("geometry").getAsJsonObject("location");
                        double latitude = location.get("lat").getAsDouble();
                        double longitude = location.get("lng").getAsDouble();

                        // get the city name from the Geocoding API response
                        String cityName = "";
                        JsonArray addressComponents = result.getAsJsonArray("address_components");
                        for (int i = 0; i < addressComponents.size(); i++) {
                            JsonObject component = addressComponents.get(i).getAsJsonObject();
                            JsonArray types = component.getAsJsonArray("types");
                            if (types != null && types.size() > 0) {
                                for (int j = 0; j < types.size(); j++) {
                                    String type = types.get(j).getAsString();
                                    if (type.equals("locality")) {
                                        cityName = component.get("long_name").getAsString();
                                        break;
                                    }
                                }
                            }
                        }

                        // update the UI with the city name
                        final String finalCityName = cityName;
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                textViewCityName.setText(finalCityName);
                            }
                        });

                        String weatherUrl = "https://api.weather.gov/points/" + latitude + "," + longitude;

                        Request weatherRequest = new Request.Builder()
                                .url(weatherUrl)
                                .build();

                        client.newCall(weatherRequest).enqueue(new Callback() {
                            @Override
                            public void onFailure(Call call, IOException e) {
                                e.printStackTrace();
                                // Handle the error
                            }

                            @Override
                            public void onResponse(Call call, Response response) throws IOException {
                                if (response.isSuccessful()) {
                                    String weatherResponseData = response.body().string();
                                    JsonObject weatherJsonObject = gson.fromJson(weatherResponseData, JsonObject.class);

                                    String forecastUrl = weatherJsonObject.getAsJsonObject("properties").get("forecast").getAsString();
                                    String forecastHourlyUrl = weatherJsonObject.getAsJsonObject("properties").get("forecastHourly").getAsString();

                                    fetchWeatherData(forecastUrl, forecastHourlyUrl);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    private void fetchWeatherData(String forecastUrl, String forecastHourlyUrl) {
        Request forecastRequest = new Request.Builder()
                .url(forecastUrl)
                .build();

        Request forecastHourlyRequest = new Request.Builder()
                .url(forecastHourlyUrl)
                .build();

        client.newCall(forecastRequest).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                e.printStackTrace();
                // Handle the error
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if (response.isSuccessful()) {
                    String forecastResponseData = response.body().string();
                    List<WeatherData> forecastData = parseForecastData(forecastResponseData);

                    client.newCall(forecastHourlyRequest).enqueue(new Callback() {
                        @Override
                        public void onFailure(Call call, IOException e) {
                            e.printStackTrace();
                            // Handle the error
                        }

                        @Override
                        public void onResponse(Call call, Response response) throws IOException {
                            if (response.isSuccessful()) {
                                String forecastHourlyResponseData = response.body().string();
                                List<WeatherData> forecastHourlyData = parseForecastHourlyData(forecastHourlyResponseData);

                                weatherDataList.clear();
                                weatherDataList.addAll(forecastData);
                                weatherDataList.addAll(forecastHourlyData);

                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        weatherAdapter.notifyDataSetChanged();
                                    }
                                });
                            }
                        }
                    });
                }
            }
        });
    }

    private List<WeatherData> parseForecastData(String responseData) {
        List<WeatherData> weatherDataList = new ArrayList<>();

        JsonObject jsonObject = gson.fromJson(responseData, JsonObject.class);
        JsonArray periods = jsonObject.getAsJsonObject("properties").getAsJsonArray("periods");

        for (int i = 0; i < periods.size(); i++) {
            JsonObject period = periods.get(i).getAsJsonObject();

            String name = period.get("name").getAsString();
            int temperature = period.get("temperature").getAsInt();
            String temperatureUnit = period.get("temperatureUnit").getAsString();
            int relativeHumidity = period.getAsJsonObject("relativeHumidity").get("value").getAsInt();
            String windSpeed = period.get("windSpeed").getAsString();
            String windDirection = period.get("windDirection").getAsString();
            String shortForecast = period.get("shortForecast").getAsString();

            WeatherData weatherData = new WeatherData(name, temperature, temperatureUnit, relativeHumidity,
                    windSpeed, windDirection, shortForecast);
            weatherDataList.add(weatherData);
        }

        return weatherDataList;
    }

    private List<WeatherData> parseForecastHourlyData(String responseData) {
        List<WeatherData> weatherDataList = new ArrayList<>();

        JsonObject jsonObject = gson.fromJson(responseData, JsonObject.class);
        JsonArray periods = jsonObject.getAsJsonObject("properties").getAsJsonArray("periods");

        for (int i = 0; i < periods.size(); i++) {
            JsonObject period = periods.get(i).getAsJsonObject();

            String name = period.get("startTime").getAsString();
            int temperature = period.get("temperature").getAsInt();
            String temperatureUnit = period.get("temperatureUnit").getAsString();
            int relativeHumidity = period.getAsJsonObject("relativeHumidity").get("value").getAsInt();
            String windSpeed = period.get("windSpeed").getAsString();
            String windDirection = period.get("windDirection").getAsString();
            String shortForecast = period.get("shortForecast").getAsString();

            WeatherData weatherData = new WeatherData(name, temperature, temperatureUnit, relativeHumidity,
                    windSpeed, windDirection, shortForecast);
            weatherDataList.add(weatherData);
        }

        return weatherDataList;
    }
}