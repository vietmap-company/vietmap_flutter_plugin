/// VietmapModel is a base model class that contains the information of a Vietmap
/// object.
class VietmapModel {
  double? lat;

  double? lng;

  String? address;

  String? name;

  String? display;
  VietmapModel({this.lat, this.lng, this.address, this.name, this.display});
}
