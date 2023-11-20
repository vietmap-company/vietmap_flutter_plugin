import '../../domain/entities/vietmap_model.dart';

class VietmapAutocompleteModel extends VietmapModel {
  String? refId;

  VietmapAutocompleteModel({
    this.refId,
    super.address,
    super.name,
    super.display,
  });

  VietmapAutocompleteModel.fromJson(Map<String, dynamic> json) {
    refId = json['ref_id'];
    address = json['address'];
    name = json['name'];
    display = json['display'];
  }

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
