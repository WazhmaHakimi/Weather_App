# Clime Weather App

A Flutter-based weather application that shows the current weather for the user's location or for a city they search for. The app displays temperature, weather description, feels-like temperature, humidity, and wind information in a clean dark-themed UI.

## Features

- Get current weather based on device location
- Search weather by city name
- Show weather icon and key metrics
- Handle permission and location errors gracefully
- Responsive, simple UI built with Flutter

## Project Structure

- lib/main.dart - app entry point
- lib/screens/home.dart - main weather screen UI and logic
- lib/services/ - location and weather API services
- lib/models/ - weather data model
- lib/components/ - reusable UI widgets
- lib/utilities/ - constants and icon mappings

## Prerequisites

- Flutter SDK installed and configured
- Android Studio / VS Code with Flutter extensions
- An Android or iOS emulator/device
- Internet connection for weather API requests

## Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Permissions

The app requests location access to show weather for the user's current position. On Android and iOS, location permission must be granted for the location-based feature to work.

## API Notes

The app uses the OpenWeatherMap API. A default API key is currently included in the project for development purposes. For production use, it is recommended to move the key to a secure configuration method such as environment variables or a build-time config file.