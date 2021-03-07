import 'package:get_it/get_it.dart';
import 'package:providers/data/time_of_prayed_api.dart';
import 'package:providers/data/weather_api_client.dart';
import 'package:providers/data/weather_repository.dart';
import 'package:providers/view_models/saved_city_view_model.dart';
import 'package:providers/view_models/weather_view_model.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
  locator.registerLazySingleton(() => WeatherViewModel());
  locator.registerLazySingleton(() => SavedCityViewModel());
  locator.registerLazySingleton(() => TimeofPrayedApiClient());
}
