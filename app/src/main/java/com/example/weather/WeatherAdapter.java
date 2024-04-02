package com.example.weather;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import java.util.List;

public class WeatherAdapter extends RecyclerView.Adapter<WeatherAdapter.WeatherViewHolder> {

    private List<WeatherData> weatherDataList;

    public WeatherAdapter(List<WeatherData> weatherDataList) {
        this.weatherDataList = weatherDataList;
    }

    @NonNull
    @Override
    public WeatherViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_weather, parent, false);
        return new WeatherViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull WeatherViewHolder holder, int position) {
        WeatherData weatherData = weatherDataList.get(position);
        holder.bind(weatherData);
    }

    @Override
    public int getItemCount() {
        return weatherDataList.size();
    }

    public static class WeatherViewHolder extends RecyclerView.ViewHolder {
        private TextView textViewName;
        private TextView textViewTemperature;
        private TextView textViewRelativeHumidity;
        private TextView textViewWindSpeed;
        private TextView textViewWindDirection;
        private TextView textViewShortForecast;

        public WeatherViewHolder(@NonNull View itemView) {
            super(itemView);
            textViewName = itemView.findViewById(R.id.textViewName);
            textViewTemperature = itemView.findViewById(R.id.textViewTemperature);
            textViewRelativeHumidity = itemView.findViewById(R.id.textViewRelativeHumidity);
            textViewWindSpeed = itemView.findViewById(R.id.textViewWindSpeed);
            textViewWindDirection = itemView.findViewById(R.id.textViewWindDirection);
            textViewShortForecast = itemView.findViewById(R.id.textViewShortForecast);
        }

        public void bind(WeatherData weatherData) {
            textViewName.setText(weatherData.getName());
            textViewTemperature.setText(String.format("%d %s", weatherData.getTemperature(), weatherData.getTemperatureUnit()));
            textViewRelativeHumidity.setText(String.format("Relative Humidity: %d%%", weatherData.getRelativeHumidity()));
            textViewWindSpeed.setText(String.format("Wind Speed: %s", weatherData.getWindSpeed()));
            textViewWindDirection.setText(String.format("Wind Direction: %s", weatherData.getWindDirection()));
            textViewShortForecast.setText(weatherData.getShortForecast());
        }
    }
}