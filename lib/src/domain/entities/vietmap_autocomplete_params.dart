import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

/// Params for VietMapAutoComplete
/// [textSearch] : (String) text that you want to search
/// [focusLocation] : (LatLng) focus location for search, the response will be sorted by distance from this location
/// Example:
/// VietMapAutoCompleteParams(
///  textSearch: 'cafe',
/// focusLocation: LatLng(10.123456, 106.123456),
/// );
class VietMapAutoCompleteParams {
  /// [textSearch] : (String) text that you want to search
  final String textSearch;

  /// [focusLocation] : (LatLng) focus location for search, the response will be sorted by distance from this location
  final LatLng? focusLocation;

  VietMapAutoCompleteParams({required this.textSearch, this.focusLocation});
}
