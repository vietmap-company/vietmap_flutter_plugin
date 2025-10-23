import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

/// This object represents an autocomplete or geocode result in Vietmap Autocomplete API version 4.
class VietmapAutocompleteModelV4 extends VietmapAutocompleteModel {
  /// [entryPoints] list containing entry points for the POI. This value will available for some special address, like airport, hotel,...
  List<VietmapEntryPointModel?>? entryPoints;

  VietmapAutocompleteModelV4({
    this.entryPoints,
    super.refId,
    super.distance,
    super.categories,
    super.boundaries,
    super.address,
    super.name,
    super.display,
    super.dataOld,
    super.dataNew,
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
          ? VietmapAutocompleteModel.fromJson(json['data_old'])
          : null,
      dataNew: json['data_new'] != null
          ? VietmapAutocompleteModel.fromJson(json['data_new'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['entry_points'] = entryPoints?.map((e) => e?.toJson()).toList();
    return data;
  }
}
