import 'package:flutter/material.dart';
import 'package:providers/data/weather_repository.dart';
import 'package:providers/locator.dart';
import 'package:providers/models/saved_city.dart';
import 'package:providers/models/weather.dart';
import 'package:providers/view_models/weather_view_model.dart';

class SavedCityViewModel with ChangeNotifier {
  WeatherRepository _repository = locator<WeatherRepository>();
  List<SavedCityModel> _savedCityList;

  SavedCityViewModel() {
    _savedCityList != null ? null : _savedCityList = [];
   getCities();
  }

  List<SavedCityModel> get savedCityList => _savedCityList;
  set savedCityList(value) {
    _savedCityList = value;
    notifyListeners();
  }

  void addCity(String model) async {
    getCities();
    Weather _weather = await locator<WeatherViewModel>().getWeather(model);

    SavedCityModel savedCity = savedCityfromWeather(weather: _weather);
    /* cityName: item.title,
        theTemp: item.consolidatedWeather[0].theTemp,
        maxTemp: item.consolidatedWeather[0].maxTemp,
        minTemp: item.consolidatedWeather[0].minTemp,
        abbr: item.consolidatedWeather[0].weatherStateAbbr);
 */
    _savedCityList.add(savedCity);
    addCities(_savedCityList);
  }

  void addCities(List<SavedCityModel> models) {
    _repository.addCitestoSP(models);
  }

  Future<List<SavedCityModel>> getCities() async {
    savedCityList = await _repository.getCitiesfromSP() != null
        ? await _repository.getCitiesfromSP()
        : [];
    
    return _savedCityList;
  }

  deleteCity(index) {} /**will added */

  SavedCityModel savedCityfromWeather({Weather weather}) {
    SavedCityModel _model;
    _model = SavedCityModel(
        cityName: weather.title,
        theTemp: weather.consolidatedWeather[0].theTemp,
        maxTemp: weather.consolidatedWeather[0].maxTemp,
        minTemp: weather.consolidatedWeather[0].minTemp,
        abbr: weather.consolidatedWeather[0].weatherStateAbbr);

    return _model;
  }
}
