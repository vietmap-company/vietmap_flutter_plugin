import '../../domain/entities/vietmap_model.dart';

// VietmapReverseModel is a model class that is used to parse the response
// from the server.
class VietmapReverseModel extends VietmapModel {
  /// [refId] is the reference id of the place.
  String? refId;

  /// [distance] is the distance of the place.
  num? distance;

  VietmapReverseModel(
      {super.lat,
      super.lng,
      this.refId,
      this.distance,
      super.address,
      super.name,
      super.display});

  /// [fromJson] is a method that is used to parse the response from the server.
  VietmapReverseModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    refId = json['ref_id'];
    distance = json['distance'];
    address = json['address'];
    name = json['name'];
    display = json['display'];
  }

  /// [toJson] is a method that is used to convert the object to a json object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['ref_id'] = refId;
    data['distance'] = distance;
    data['address'] = address;
    data['name'] = name;
    data['display'] = display;
    return data;
  }
}
