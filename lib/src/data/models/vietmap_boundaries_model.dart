/// VietmapBoundaries is a model class that is used to parse the boundaries information from the server.
/// This describes the administrative boundaries such as ward, district, and city.
class VietmapBoundaries {
  /// Type of boundary (0 for city, 1 for district, 2 for ward)
  final num? type;

  /// Unique identifier for the boundary
  final num? id;

  /// Name of the boundary
  final String? name;

  /// Prefix of the boundary (e.g., "Phường" for ward)
  final String? prefix;

  /// Full name of the boundary (e.g., "Phường 9" for ward)
  final String? fullName;

  VietmapBoundaries(
      {this.type, this.id, this.name, this.prefix, this.fullName});
  factory VietmapBoundaries.fromJson(Map<String, dynamic> json) {
    return VietmapBoundaries(
        type: json['type'],
        id: json['id'],
        name: json['name'],
        prefix: json['prefix'],
        fullName: json['full_name']);
  }
  toJson() {
    return {
      'type': type,
      'id': id,
      'name': name,
      'prefix': prefix,
      'full_name': fullName
    };
  }
}
