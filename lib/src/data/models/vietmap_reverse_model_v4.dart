import 'package:vietmap_flutter_plugin/src/data/models/vietmap_entry_point_model.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

/// This object represents a reverse geocode result in Vietmap Reverse API version 4.
class VietmapReverseModelV4 extends VietmapReverseModel {
  /// [entryPoints] Array containing entry point information for the location
  List<VietmapEntryPointModel?>? entryPoints;

  /// [dataOld] Location object in the old admin format (3 levels). Available for hybrid display types (e.g., 5), otherwise null.
  VietmapReverseModelV4? dataOld;

  /// [dataNew] Location object in the new merged admin format (2 levels). Available for hybrid display types (e.g., 6), otherwise null.
  VietmapReverseModelV4? dataNew;

  VietmapReverseModelV4({
    this.entryPoints,
    this.dataOld,
    this.dataNew,
    super.refId,
    super.distance,
    super.categories,
    super.boundaries,
    super.lat,
    super.lng,
    super.address,
    super.name,
    super.display,
  });

  factory VietmapReverseModelV4.fromJson(Map<String, dynamic> json) {
    return VietmapReverseModelV4(
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
      entryPoints: json['entry_points'] != null
          ? List<VietmapEntryPointModel?>.from(json['entry_points']
              .map((x) => VietmapEntryPointModel.fromJson(x)))
          : [],
      dataOld: json['data_old'] != null
          ? VietmapReverseModelV4.fromJson(json['data_old'])
          : null,
      dataNew: json['data_new'] != null
          ? VietmapReverseModelV4.fromJson(json['data_new'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['entry_points'] = entryPoints?.map((e) => e?.toJson()).toList();
    if (dataOld != null) {
      data['data_old'] = dataOld?.toJson();
    }
    if (dataNew != null) {
      data['data_new'] = dataNew?.toJson();
    }
    return data;
  }
}
