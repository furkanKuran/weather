import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeofPrayedApiClient {
  static const String baseUrl =
      "https://api.collectapi.com/weather/getWeather?data.city=ankara";
  http.Client httpClient = http.Client();
  getCountryID(String countryName) async {
    http.Response response = await http.get(baseUrl,
        headers:{"apikey": "3DiZtAnHfjZl6z12bjbAXJ:4BIk7p7V3lKwuPdQz4QpW3"},);
    debugPrint(response.body);
  }
}
