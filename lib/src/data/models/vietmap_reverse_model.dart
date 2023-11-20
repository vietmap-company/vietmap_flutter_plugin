 
import '../../domain/entities/vietmap_model.dart';

class VietmapReverseModel extends VietmapModel {
  String? refId;
  double? distance;

  VietmapReverseModel(
      {super.lat,
      super.lng,
      this.refId,
      this.distance,
      super.address,
      super.name,
      super.display});
  VietmapReverseModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    refId = json['ref_id'];
    distance = json['distance'];
    address = json['address'];
    name = json['name'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['ref_id'] = refId;
    data['distance'] = distance;
    data['address'] = address;
    data['name'] = name;
    data['display'] = display;
    return data;
  }
}
