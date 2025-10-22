import '../../domain/entities/vietmap_model.dart';

/// VietmapPlaceModel is a model class that is used to parse the response
/// from the server.
class VietmapPlaceModel extends VietmapModel {
  /// [hsNum] is the house number of the place.
  String? hsNum;

  /// [street] is the street of the place.
  String? street;

  /// [cityId] is the city id of the place.
  int? cityId;

  /// [city] is the city of the place.
  String? city;

  /// [districtId] is the district id of the place.
  int? districtId;

  /// [district] is the district of the place.
  String? district;

  /// [wardId] is the ward id of the place.
  int? wardId;

  /// [ward] is the ward of the place.
  String? ward;
  VietmapPlaceModel({
    super.display,
    super.name,
    super.lat,
    super.lng,
    super.address,
    this.hsNum,
    this.street,
    this.cityId,
    this.city,
    this.districtId,
    this.district,
    this.wardId,
    this.ward,
  });

  /// [fromJson] is a method that is used to parse the response from the server.
  VietmapPlaceModel.fromJson(Map<String, dynamic> json) {
    display = json['display'];
    name = json['name'];
    hsNum = json['hs_num'];
    street = json['street'];
    address = json['address'];
    cityId = json['city_id'];
    city = json['city'];
    districtId = json['district_id'];
    district = json['district'];
    wardId = json['ward_id'];
    ward = json['ward'];
    lat = json['lat'];
    lng = json['lng'];
  }

  /// [toJson] is a method that is used to convert the object to a json object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display'] = display;
    data['name'] = name;
    data['hs_num'] = hsNum;
    data['street'] = street;
    data['address'] = address;
    data['city_id'] = cityId;
    data['city'] = city;
    data['district_id'] = districtId;
    data['district'] = district;
    data['ward_id'] = wardId;
    data['ward'] = ward;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  /// [toString] is a method that is used to convert the object to a string.
  String getAddress() {
    var data = [hsNum, street, ward, district, city];
    return data
        .where((element) => element != null && element.isNotEmpty)
        .join(', ');
  }


  @override
  String toString() {
    return 'VietmapPlaceModel{$display, lat: $lat, lng: $lng, address: $address}';
  }
}
