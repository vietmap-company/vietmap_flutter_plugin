/// VietmapModel is a base model class that contains the information of a Vietmap
/// object.
class VietmapModel {
  /// [lat] is the latitude of the place.
  num? lat;

  /// [lng] is the longitude of the place.
  num? lng;

  /// [address] is the address of the place.
  String? address;

  /// [name] is the name of the place.
  String? name;

  /// [display] is the display name of the place.
  String? display;
  VietmapModel({this.lat, this.lng, this.address, this.name, this.display});
}
