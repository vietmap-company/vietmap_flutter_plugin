import 'package:vietmap_flutter_plugin/src/data/models/vietmap_boundaries_model.dart';

import '../../domain/entities/vietmap_model.dart';

// VietmapReverseModel is a model class that is used to parse the response
// from the server.
class VietmapReverseModel extends VietmapModel {
  /// [refId] is the reference id of the place.
  String? refId;

  /// [distance] is the distance of the place.
  num? distance;

  /// [categories] Array containing categories associated with the location.
  List<String?>? categories;

  /// [boundaries] Array containing boundary information (ward, district, city).
  List<VietmapBoundaries?>? boundaries;

  VietmapReverseModel({
    super.lat,
    super.lng,
    this.refId,
    this.distance,
    this.categories,
    this.boundaries,
    super.address,
    super.name,
    super.display,
  });

  /// [fromJson] is a method that is used to parse the response from the server.
  factory VietmapReverseModel.fromJson(Map<String, dynamic> json) {
    return VietmapReverseModel(
      lat: json['lat'],
      lng: json['lng'],
      refId: json['ref_id'],
      distance: json['distance'],
      address: json['address'],
      name: json['name'],
      display: json['display'],
      categories: json['categories'] != null
          ? List<String?>.from(json['categories'])
          : [],
      boundaries: json['boundaries'] != null
          ? List<VietmapBoundaries?>.from(
              json['boundaries'].map((x) => VietmapBoundaries.fromJson(x)))
          : [],
    );
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
    data['categories'] = categories;
    data['boundaries'] = boundaries?.map((e) => e?.toJson()).toList();
    return data;
  }
}
