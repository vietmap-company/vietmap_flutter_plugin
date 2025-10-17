class VietmapEntryPointModel {
  /// [ref_id] Reference ID for the Point of Interest (POI)
  final String? refId;

  /// [name] Name of the Point of Interest (POI)
  final String? name;

  VietmapEntryPointModel({this.refId, this.name});

  factory VietmapEntryPointModel.fromJson(Map<String, dynamic> json) {
    return VietmapEntryPointModel(
      refId: json['ref_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ref_id': refId,
      'name': name,
    };
  }
}
