import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

class VietMapAutoCompleteParams {
  final String textSearch;
  final LatLng? focusLocation;

  VietMapAutoCompleteParams({required this.textSearch, this.focusLocation});
}
