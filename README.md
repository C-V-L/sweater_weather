# README

Sweater Weather

Project Learning Goals
-Consume multiple external APIs
  - WeatherAPI provides detailed weather forecast data
  - MapQuestAPI provides detailed trip planning data
-Aggregate API responses, create methods to parse through and combine desired data
-Expose API endpoints that allow a user to post a new user, create a session through login, fetch weather details for a city, and plan a road trip and know expect weather at arrival.
-Exposed endpoints require a valid API key to consume


 ### Built With:

* [![Ruby]][Ruby-url] **3.1.1**
* [![Rails]][Rails-url] **7.0.4**
* [![Postgresql]][Postgresql-url]

### Installation

1. Clone the repo:
```bash
   git git@github.com:C-V-L/sweater_weather.git
```

1. Install gems:
```bash
   bundle install
```

### API Key Setup
In order to use this application you will API keys from both <a href="https://www.weatherapi.com/docs/"> `WeatherAPI` </a> and <a href="https://developer.mapquest.com/"> `MapQuestAPI` 
Once you have these keys, they will need to be stored in an config/application.yml that you create.
Label these keys as follows-
MAPQUEST_API_KEY: 
WEATHER_API_KEY: 

### Testing with RSpec

Once the application is correctly installed, run tests locally to ensure the repository works as intended.

<br>

  To test the entire RSpec suite, run:
```bash
   bundle exec rspec
```

<br>

### Local Postman

run `rails s`

First create a user via POST http://localhost:3000/api/v1/users ; you will need to pass data as a json payload in the following format.

{
  "email": "email@gmail.com",
  "password": "password",
  "password_confirmation": "password"
}

This will return an api key that will be needing to run the following:

POST http://localhost:3000/api/v1/sessions
POST http://localhost:3000/api/v1/road_trip
POST http://localhost:3000/api/v1/forecast