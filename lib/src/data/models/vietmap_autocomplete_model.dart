import '../../domain/entities/vietmap_model.dart';

// VietmapAutocompleteModel is a model class that is used to parse the response
// from the server.
class VietmapAutocompleteModel extends VietmapModel {
  /// [refId] is the reference id of the place.
  String? refId;

  VietmapAutocompleteModel({
    this.refId,
    super.address,
    super.name,
    super.display,
  });

  /// [fromJson] is a method that is used to parse the response from the server.
  VietmapAutocompleteModel.fromJson(Map<String, dynamic> json) {
    refId = json['ref_id'];
    address = json['address'];
    name = json['name'];
    display = json['display'];
  }

  /// [toJson] is a method that is used to convert the object to a json object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ref_id'] = refId;
    data['address'] = address;
    data['name'] = name;
    data['display'] = display;
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
