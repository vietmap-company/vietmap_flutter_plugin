import 'package:vietmap_flutter_plugin/src/data/models/vietmap_entry_point_model.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';


class VietmapAutocompleteModelV4 extends VietmapAutocompleteModel {
  /// [entryPoints] list containing entry points for the POI. This value will available for some special address, like airport, hotel,...
  List<VietmapEntryPointModel?>? entryPoints;

  /// [dataOld] Old-format variant of this result (when applicable to the chosen display type), otherwise null.
  VietmapAutocompleteModelV4? dataOld;

  /// [dataNew] New-format variant of this result (when applicable to the chosen display type), otherwise null.
  VietmapAutocompleteModelV4? dataNew;

  VietmapAutocompleteModelV4({
    this.entryPoints,
    this.dataOld,
    this.dataNew,
    super.refId,
    super.distance,
    super.categories,
    super.boundaries,
    super.address,
    super.name,
    super.display,
  });

  factory VietmapAutocompleteModelV4.fromJson(Map<String, dynamic> json) {
    return VietmapAutocompleteModelV4(
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
          ? VietmapAutocompleteModelV4.fromJson(json['data_old'])
          : null,
      dataNew: json['data_new'] != null
          ? VietmapAutocompleteModelV4.fromJson(json['data_new'])
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
