import 'package:vietmap_flutter_plugin/src/data/models/vietmap_boundaries_model.dart';

/// This model represents the response from the Vietmap Migrate Address API.
class VietmapMigrateAddressModel {
  /// Full address including street, ward, and city.
  final String? address;

  /// Name of the POI/Address
  final String? name;

  /// Display name containing detailed information of the POI address
  final String? display;

  /// Array containing boundary information (ward, district, city)
  final List<VietmapBoundaries?>? boundaries;

  VietmapMigrateAddressModel({
    this.address,
    this.name,
    this.display,
    this.boundaries,
  });

  factory VietmapMigrateAddressModel.fromJson(Map<String, dynamic> json) {
    return VietmapMigrateAddressModel(
      address: json['address'],
      name: json['name'],
      display: json['display'],
      boundaries: json['boundaries'] != null
          ? List<VietmapBoundaries?>.from(
              json['boundaries'].map((e) => VietmapBoundaries.fromJson(e)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'display': display,
      'boundaries': boundaries?.map((e) => e?.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'VietmapMigrateAddressModel{address: $address, name: $name, display: $display, boundaries: $boundaries}';
  }
}
