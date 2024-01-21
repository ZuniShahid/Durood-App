class CountriesModel {
  final int? id;
  final String? name;
  final String? nicename;
  final String? code;
  final String? iso3;
  final String? numcode;
  final int? phonecode;
  final double? latitude;
  final double? longitude;

  CountriesModel({
    this.id,
    this.name,
    this.nicename,
    this.code,
    this.iso3,
    this.numcode,
    this.phonecode,
    this.latitude,
    this.longitude,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        id: json["id"],
        name: json["name"],
        nicename: json["nicename"],
        code: json["code"],
        iso3: json["iso3"],
        numcode: json["numcode"],
        phonecode: json["phonecode"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nicename": nicename,
        "code": code,
        "iso3": iso3,
        "numcode": numcode,
        "phonecode": phonecode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
