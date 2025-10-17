import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

/// Params for VietMapAutoComplete
/// [textSearch] : (String) text that you want to search
/// [focusLocation] : (LatLng) focus location for search, the response will be sorted by distance from this location
/// [displayType] : (int) Result display type. Follow [AutocompleteDisplayType] for more detail
/// [cityId] : (int) Every city has a unique ID, which is used to filter search results
/// [distId] : (int) Every district has a unique ID, which is used to filter search results
/// [wardId] : (int) Every ward has a unique ID, which is used to filter search results
/// [circleCenter] : (LatLng) The central coordinate position of the area to be searched
/// [circleRadius] : (int) The radius of the search area (in meters)
/// [cats] : (String) Provide full list of POI categories
/// [layers] : (String) Represent for certain type of data such as POI,ADDRESS,VILLAGE,WARD,DIST,CITY,STREET
/// Example:
/// VietMapAutoCompleteParams(
///  textSearch: 'cafe',
///  focusLocation: LatLng(10.759119885168527, 106.6759602315203),
///  displayType: 1,
///  cityId: 12,
///  distId: 1292,
///  wardId: 984332,
///  circleCenter: LatLng(10.759119885168527, 106.6759602315203),
///  circleRadius: 200,
///  cats: '1002-1',
///  layers: 'POI',
/// );
class VietMapAutoCompleteParams {
  /// [textSearch] : ([String]) text that you want to search
  final String textSearch;

  /// [focusLocation] : ([LatLng]) focus location for search, the response will be sorted by distance from this location
  final LatLng? focusLocation;

  VietMapAutoCompleteParams({
    required this.textSearch,
    this.focusLocation,
  });
}
