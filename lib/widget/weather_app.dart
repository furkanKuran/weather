import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providers/data/time_of_prayed_api.dart';
import 'package:providers/models/saved_city.dart';
import 'package:providers/my_globals.dart';
import 'package:providers/view_models/saved_city_view_model.dart';
import 'package:providers/view_models/theme_view_model.dart';
import 'package:providers/view_models/weather_view_model.dart';
import 'package:providers/widget/background_color.dart';
import 'package:providers/widget/select_city_screen.dart';
import 'package:providers/widget/weather_detail_widget.dart';

import '../locator.dart';

class WeatherApp extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCity = "";
  @override
  Widget build(BuildContext context) {
    var _weatherProvider = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      key: myGlobals.scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              selectedCity = await Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) => SelectCityScreen(),
                ),
              );

              _weatherProvider.getWeather(selectedCity);

              debugPrint(selectedCity);
            },
          )
        ],
      ),
      drawer: getDrawer(),
      body: Center(
        child: (_weatherProvider.state == WeatherState.WeatherLoadedState)
            ? LoadedWeather()
            : (_weatherProvider.state == WeatherState.WeatherLoadingState)
                ? loadingState()
                : (_weatherProvider.state == WeatherState.WeatherErrorState)
                    ? errorState()
                    : startedState(),

        /* Text(
                                                                "Please choose a city.",
                                                                style: TextStyle(
                                                                    fontSize: 24, fontWeight: FontWeight.w600),
                                                              ), */
      ),
    );
  }

  errorState() {
    return Text("Error!  Please try enter city name again");
  }

  loadingState() {
    return CircularProgressIndicator();
  }

  startedState() {
    //locator<TimeofPrayedApiClient>().getCountryID("ankara");
    /* if (locator<SavedCityViewModel>().savedCityList.length != 0) {
       List<SavedCityModel> cities =
        await locator<SavedCityViewModel>().savedCityList;
      locator<WeatherViewModel>().getWeather(cities[cities.length].cityName);
      return CircularProgressIndicator();
    } else { */
    return Text("Please choose a city");
    // }
    /*  Son save edilen şehir getirilecek*/
  }
}

getDrawer() {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 28, 8, 8),
            child: TextButton(
              child: Text(
                "Home",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {},
            )),
        RaisedButton(
          color: Colors.black54,
          hoverColor: Colors.white54,
          textColor: Colors.white54,
          padding: EdgeInsets.all(8),
          textTheme: ButtonTextTheme.accent,
          onPressed: () {},
          child: Center(
            child: Icon(
              Icons.settings,
            ),
          ),
        )
      ],
    ),
  );
}

class LoadedWeather extends StatefulWidget {
  @override
  _LoadedWeatherState createState() => _LoadedWeatherState();
}

class _LoadedWeatherState extends State<LoadedWeather> {
  @override
  Completer<void> _refreshIndicator;
  void initState() {
    super.initState();
    _refreshIndicator = Completer<void>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ThemeViewModel>(context, listen: false).changeThemeofApp(
          Provider.of<WeatherViewModel>(context, listen: false)
              .weather
              .consolidatedWeather[0]
              .weatherStateAbbr);
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshIndicator.complete();
    debugPrint("_refreshIndicator has completed:::::::" +
        _refreshIndicator.isCompleted.toString());
    _refreshIndicator = Completer<void>();
    debugPrint("refreshIndicator has created again  ::::::" +
        _refreshIndicator.isCompleted.toString());
    return BackGroundColor(
      color: Provider.of<ThemeViewModel>(context).color,
      child: RefreshIndicator(
        color: Colors.teal,
        onRefresh: () {
          Provider.of<WeatherViewModel>(context, listen: true).updateWeather(
              Provider.of<WeatherViewModel>(context, listen: true)
                  .weather
                  .title);

          debugPrint("RefreshIndicator kodda okundu!!");
          return _refreshIndicator.future;
        },
        child: WeatherDetailWidget(),
      ),
    );
  }
}
