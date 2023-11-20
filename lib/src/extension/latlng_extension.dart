import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

extension LatLngExtension on LatLng {
  String toUrlValue() {
    return '$latitude,$longitude';
  }
}
