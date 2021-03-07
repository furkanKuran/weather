import 'package:flutter/material.dart';
import 'package:providers/data/weather_api_client.dart';
import 'package:providers/models/weather.dart';
import 'package:providers/models/saved_city.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../locator.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();
  Future<Weather> getWeatherfromDb(String cityName) async {
    int cityID = await weatherApiClient.getLocationID(cityName);
    return await weatherApiClient.getWeather(cityID);
  }

  addCitestoSP(List<SavedCityModel> models) async {
    try {
      SharedPreferences sPref = await SharedPreferences.getInstance();
      List<String> convertedtoJsonModel = [];

      for (var model in models) {
        convertedtoJsonModel.add(json.encode(model.toJson()));
      }
      sPref.setStringList("cities", convertedtoJsonModel);
      debugPrint("addCitiestoSP is complated");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<SavedCityModel>> getCitiesfromSP() async {
    List<String> citiesStrings;
    List<SavedCityModel> cityModels = [];
    SharedPreferences sPref = await SharedPreferences.getInstance();
    citiesStrings = sPref.getStringList("cities");

    if (citiesStrings != null) {
      if (citiesStrings.length > 10) {
        citiesStrings.removeAt(0);
        debugPrint(citiesStrings.toString());
      }
      for (var item in citiesStrings) {
        cityModels.add(SavedCityModel.fromJson(jsonDecode(item)));
      }
    }

    return cityModels;
  }
}
