class VietmapBoundaries {
  final num? type;
  final num? id;
  final String? name;
  final String? prefix;
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
