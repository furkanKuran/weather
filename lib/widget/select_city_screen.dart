import 'package:flutter/material.dart';
import 'package:providers/view_models/saved_city_view_model.dart';
import 'package:providers/view_models/weather_view_model.dart';
import 'package:providers/widget/saved_city_widget.dart';

import '../locator.dart';

class SelectCityScreen extends StatefulWidget {
  @override
  _SelectCityScreenState createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select City"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: TextFormField(
                        autofocus: true,
                        controller: _textController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelText: "Select city"),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_textController.text != "") {
                      locator<SavedCityViewModel>()
                          .addCity(_textController.text);
                      Navigator.pop(context, _textController.text);
                    } else {
                      Navigator.pop(context, "ankara");
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: SavedCityWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
/*ChangeNotifierProvider(
                create: (context) => OldSearchModel(),
                child: SavedCityWidget(),
              ), */
// Geçmişte aranan şehirlerin listesi Net ile bağlanacak.
