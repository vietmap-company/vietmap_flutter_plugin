import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

// VietmapAutocompleteModel is a model class that is used to parse the response
// from the server.
class VietmapAutocompleteModel extends VietmapModel {
  /// [refId] is the reference id of the place.
  String? refId;

  /// [distance] is the distance of the place from the location of the user.
  num? distance;

  /// [categories] list containing categories associated with the POI.
  List<String?>? categories;

  /// [boundaries] list containing boundary information (ward, district, city).
  List<VietmapBoundaries?>? boundaries;

  VietmapAutocompleteModel({
    this.refId,
    this.distance,
    this.categories,
    this.boundaries,
    super.address,
    super.name,
    super.display,
  });

  /// [fromJson] is a method that is used to parse the response from the server.
  factory VietmapAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return VietmapAutocompleteModel(
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
            : []);
  }

  /// [toJson] is a method that is used to convert the object to a json object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ref_id'] = refId;
    data['address'] = address;
    data['name'] = name;
    data['display'] = display;
    data['categories'] = categories;
    data['boundaries'] = boundaries?.map((e) => e?.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'VietmapAutocompleteModel{refId: $refId, address: $address, name: $name, display: $display}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VietmapAutocompleteModel &&
          runtimeType == other.runtimeType &&
          refId == other.refId &&
          address == other.address &&
          name == other.name &&
          display == other.display;

  @override
  int get hashCode =>
      refId.hashCode ^ address.hashCode ^ name.hashCode ^ display.hashCode;
}
