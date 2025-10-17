import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class VietmapReverseParams {
  /// [latLng] is the latitude and longitude of the location.
  final LatLng latLng;

  /// [displayType] is the display type of the reverse geocoding result, which determines how the result is presented.
  /// [ReverseDisplayType] is the enum that defines the available display types.
  final int? displayType;

  VietmapReverseParams({required this.latLng, this.displayType = 2});
}
