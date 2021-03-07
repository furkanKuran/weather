import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:providers/locator.dart';
import 'package:providers/models/saved_city.dart';
import 'package:providers/view_models/saved_city_view_model.dart';
import 'package:providers/view_models/weather_view_model.dart';

class SavedCityWidget extends StatefulWidget {
  @override
  _SavedCityWidgetState createState() => _SavedCityWidgetState();
}

class _SavedCityWidgetState extends State<SavedCityWidget> {
  List<SavedCityModel> cityList = [];
  var _savedCityViewModel = locator<SavedCityViewModel>();
  @override
  TextEditingController _controller = TextEditingController();
  Widget build(BuildContext context) {
    _savedCityViewModel.getCities();
    cityList = _savedCityViewModel.savedCityList;
    return cityList.length == 0
        ? Container(
            child: IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.tealAccent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 26,
                          ),
                          Text("Enter the city name please"),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              controller: _controller,
                              cursorRadius: Radius.circular(12),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                labelText: "City Name",
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FlatButton(
                                onPressed: null,
                                child: Text("cancel"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  locator<SavedCityViewModel>()
                                      .addCity(_controller.text);
                                },
                                child: Text("save"),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
                /* SimpleDialog(
                  title: Text("Please write city name"),
                  backgroundColor: Colors.teal.shade300,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _controller,
                    ),
                    ButtonBar(
                      children: [
                        RaisedButton(
                          onPressed: () {
                            var _weatherProv = locator<WeatherViewModel>();
                            _weatherProv.getWeather(_controller.text);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                );
                /*  Navigator.push( */
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleDialogWidget(cityList.length),
                  ),
                ); */
              },
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  
                  reverse: true,
                  itemCount: cityList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cityList[index].cityName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                      trailing: getAbbrImages(cityList[index].abbr),
                      backgroundColor: Colors.teal.shade300,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.cancel_presentation_sharp,
                                  color: Colors.black,
                                ),
                                onPressed: locator<SavedCityViewModel>()
                                    .deleteCity(index)),
                            Column(
                              children: [
                                Text(
                                  cityList[index].theTemp.toString(),
                                ),
                                Text(
                                  cityList[index].maxTemp.toString(),
                                ),
                                Text(
                                  cityList[index].minTemp.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_box_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.tealAccent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 26,
                            ),
                            Text("Enter the city name please"),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                controller: _controller,
                                cursorRadius: Radius.circular(12),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  labelText: "City Name",
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FlatButton(
                                  onPressed: null,
                                  child: Text("cancel"),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    locator<SavedCityViewModel>()
                                        .addCity(_controller.text);
                                  },
                                  child: Text("save"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
  }
}

getAbbrImages(String abbr) {
  return Image.asset("images/" + abbr + ".png");
}
/*ListView(
      children: [
        
                IconButton(
                  icon: Icon(
                    Icons.arrow_drop_up,
                    size: 72,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
        IconButton(icon: Icon(Icons.add,size: 32,color: Colors.grey.shade500,), onPressed: (){})
      ],
    ) */
