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
class VietmapAutocompleteParamsV4 extends VietMapAutoCompleteParams {
  /// [displayType] : (int) Result display type. Follow [AutocompleteDisplayType] for more detail
  final int? displayType;

  /// [cityId] : ([int]) Every city has a unique ID, which is used to filter search results
  final int? cityId;

  /// [distId] : ([int]) Every district has a unique ID, which is used to filter search results
  final int? distId;

  /// [wardId] : ([int]) Every ward has a unique ID, which is used to filter search results
  final int? wardId;

  /// [circleCenter] : ([LatLng]) The central coordinate position of the area to be searched
  final LatLng? circleCenter;

  /// [circleRadius] : ([int]) The radius of the search area (in meters)
  final int? circleRadius;

  /// [cats] : ([String]) Provide full list of POI categories
  final String? cats;

  /// [layers] : ([String]) Represent for certain type of data such as POI,ADDRESS,VILLAGE,WARD,DIST,CITY,STREET
  final String? layers;

  VietmapAutocompleteParamsV4({
    required String text,
    LatLng? focusLocation,
    this.displayType,
    this.cityId,
    this.distId,
    this.wardId,
    this.circleCenter,
    this.circleRadius,
    this.cats,
    this.layers,
  }) : super(
          textSearch: text,
          focusLocation: focusLocation,
        );

  Map<String, dynamic> toQueryParam() {
    final Map<String, String> queryParams = {};
    queryParams['text'] = textSearch;
    if (focusLocation != null) {
      queryParams['focus'] = focusLocation!.toUrlValue();
    }
    if (displayType != null) {
      queryParams['display_type'] = displayType.toString();
    }
    if (cityId != null) {
      queryParams['cityId'] = cityId.toString();
    }
    if (distId != null) {
      queryParams['distId'] = distId.toString();
    }
    if (wardId != null) {
      queryParams['wardId'] = wardId.toString();
    }
    if (circleCenter != null) {
      queryParams['circle_center'] = circleCenter!.toUrlValue();
    }
    if (circleRadius != null) {
      queryParams['circle_radius'] = circleRadius.toString();
    }
    if (cats != null) {
      queryParams['cats'] = cats!;
    }
    if (layers != null) {
      queryParams['layers'] = layers!;
    }
    return queryParams;
  }
}
