import 'dart:convert';

class SavedCityModel {
  final String cityName;
  final String abbr;
  final double maxTemp;
  final double minTemp;
  final double theTemp;

  SavedCityModel({
    this.cityName,
    this.abbr,
    this.maxTemp,
    this.minTemp,
    this.theTemp,
  });

  factory SavedCityModel.fromJson(Map<String, dynamic> json) =>
      new SavedCityModel(
        cityName: json["cityName"] == null ? null : json["cityName"],
        abbr: json["abbr"] == null ? null : json["abbr"],
        maxTemp: json["maxTemp"] == null ? null : double.parse(json["maxTemp"]),
        minTemp: json["minTemp"] == null ? null : double.parse(json["minTemp"]),
        theTemp: json["theTemp"] == null ? null : double.parse(json["theTemp"]),
      );

  String savedCityToJson(SavedCityModel data) => json.encode(data.toJson());
  Map<String, dynamic> toJson() => {
        "cityName": cityName == null ? null : cityName,
        "abbr": abbr == null ? null : abbr,
        "maxTemp": maxTemp == null ? null : maxTemp.toString(),
        "minTemp": minTemp == null ? null : minTemp.toString(),
        "theTemp": theTemp == null ? null : theTemp.toString(),
      };
}
