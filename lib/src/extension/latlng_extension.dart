import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

extension LatLngExtension on LatLng {
  /// Convert [LatLng] to [String] with format: 'latitude,longitude'
  /// Example: '10.123456,106.123456'
  /// return [String]
  String toUrlValue() {
    return '$latitude,$longitude';
  }
}
