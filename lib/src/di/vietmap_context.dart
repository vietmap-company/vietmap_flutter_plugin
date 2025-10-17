import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_reverse_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_reverse_params.dart';
import 'package:vietmap_flutter_plugin/src/domain/repository/vietmap_api_repositories.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/autocomplete_location_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/geocode_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/get_location_from_latlng_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/matrix_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/reverse_location_from_latlng_usecase.dart';

import '../../vietmap_flutter_plugin.dart';
import '../domain/usecase/get_direction_usecase.dart';
import '../domain/usecase/get_place_detail_usecase.dart';
import '../domain/usecase/search_address_usecase.dart';

// Vietmap is a singleton class that provides access to Vietmap APIs.
// Before using any APIs, you must call Vietmap.getInstance(apiKey) to set
// API key for Vietmap APIs library.
class Vietmap {
  static final Vietmap _singleton = Vietmap._internal();
  static String _vietmapAPIKey = "";
  factory Vietmap() {
    return _singleton;
  }
  Vietmap._internal();

  // Get API key for Vietmap APIs
  static String getVietmapAPIKey() {
    return _vietmapAPIKey;
  }

  // Must call this method before use Vietmap APIs.
  // This method will set API key for Vietmap APIs library
  static void getInstance(String apiKey) {
    _vietmapAPIKey = apiKey;
  }

  // Get style url for VietmapGL plugin
  static String getVietmapStyleUrl() {
    if (_vietmapAPIKey.isEmpty) {
      throw Exception('Please call `Vietmap.getInstance(apiKey)` before use');
    }
    return 'https://maps.vietmap.vn/api/maps/light/styles.json?apikey=$_vietmapAPIKey';
  }

  /// Get base url for Vietmap APIs
  static String getVietmapBaseUrl() {
    if (_vietmapAPIKey.isEmpty) {
      throw Exception('Please call `Vietmap.getInstance(apiKey)` before use');
    }
    return 'https://maps.vietmap.vn/api/';
  }

  // Get VietmapApiRepositories instance
  static VietmapApiRepositories getVietmapApiRepositories() {
    return VietmapApiRepositories();
  }

  // Updating Autocomplete 3.0 API is a valuable resources that allows
  // developers to integrate autocomplete functionality into their applications.
  // This API is designed to help users quickly find and select items from a
  // large set of options by suggesting potential matches as they type.
  // The API is built on a machine learning model that analyzes user input and
  // suggests potential matches based on the context of the search. This model
  // can be updated in real-time, allowing the API to continuously improve its
  // suggestions as more data becomes available
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use autocomplete instead. See https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4')
  static Future<Either<Failure, List<VietmapAutocompleteModel>>> autocomplete(
      VietMapAutoCompleteParams params) {
    return SearchAddressUseCase(getVietmapApiRepositories()).call(params);
  }

  // Updating Autocomplete 4.0 API is a valuable resources that allows
  // developers to integrate autocomplete functionality into their applications.
  // This API is designed to help users quickly find and select items from a
  // large set of options by suggesting potential matches as they type.
  // The API is built on a machine learning model that analyzes user input and
  // suggests potential matches based on the context of the search. This model
  // can be updated in real-time, allowing the API to continuously improve its
  // suggestions as more data becomes available
  // See more at https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4
  static Future<Either<Failure, List<VietmapAutocompleteModelV4>>> autocompleteV4(
      VietmapAutocompleteParamsV4 params) {
    return AutocompleteLocationUsecase(getVietmapApiRepositories())
        .call(params);
  }

  // Updating Reverse 3.0 API is a valuable resource for developers who want to
  // incorporate location search features into their applications while
  // achieving optimal performance. With its intelligent search algorithms
  // and techniques, this latest version can swiftly deliver precise search
  // results for users. This API is a powerful tool that can help enhance the
  // user experience of location-based applications.
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use reverse instead. See https://maps.vietmap.vn/docs/map-api/reverse-version/reverse-v4')
  static Future<Either<Failure, VietmapReverseModel>> reverse(LatLng location) {
    return GetLocationFromLatLngUseCase(getVietmapApiRepositories())
        .call(LatLng(location.latitude, location.longitude));
  }

  // Updating Reverse 4.0 API is a valuable resource for developers who want to
  // incorporate location search features into their applications while
  // achieving optimal performance. With its intelligent search algorithms
  // and techniques, this latest version can swiftly deliver precise search
  // results for users. This API is a powerful tool that can help enhance the
  // user experience of location-based applications.
  // This version supports new administrative format (2 levels: ward, city)
  // and old administrative format (3 levels: ward, district, city).
  // You can choose display type via [VietmapReverseParams.displayType]
  // Responses can include data_old/data_new to carry the alternate format.
  // See more at https://maps.vietmap.vn/docs/map-api/reverse-version/reverse-v4
  static Future<Either<Failure, VietmapReverseModelV4>> reverseV4(
      VietmapReverseParams params) {
    return ReverseLocationFromLatlngUsecase(getVietmapApiRepositories())
        .call(params);
  }

  // The Matrix API calculate many-to-many distances and times a lot more
  // efficient than calling the Routing API multiple times
  static Future<Either<Failure, VietmapMatrixModel>> matrix(
      VietmapMatrixParams params) {
    return MatrixUseCase(getVietmapApiRepositories()).call(params);
  }

  // The Place API service endpoint provides detailed information about the
  // Place found by its identifier (refid).
  static Future<Either<Failure, VietmapPlaceModel>> place(String placeId) {
    return GetPlaceDetailUseCase(getVietmapApiRepositories()).call(placeId);
  }

  // A Route Maps API is a feature provided by VIETMAP that allows developers to
  // calculate and display the optimal route between two or more locations on
  // a map. With a Route Maps API, developers can specify the start and end
  // points of a journey, along with any additional constraints such as preferred
  // mode of transportation, and retrieve a detailed route that can be displayed
  // on a map. The API may also provide information such as the total distance,
  // estimated travel time, and turn-by-turn directions. Developers can use
  // Route Maps APIs to create applications that help with navigation,
  // transportation planning, and logistics management.
  static Future<Either<Failure, VietMapRoutingModel>> routing(
      VietMapRoutingParams vietMapRoutingParams) {
    return GetDirectionUseCase(getVietmapApiRepositories())
        .call(vietMapRoutingParams);
  }

  // Updating Geocode 3.0 API is a powerful tool for developers to integrate
  // location search functionality into their applications with optimized
  //performance. Additionally, this latest version utilizes intelligent search
  //algorithms and methods to provide accurate and speedy search results for users.
  static Future<Either<Failure, List<VietmapAutocompleteModel>>> geoCode(
      VietMapAutoCompleteParams params) {
    return GeoCodeUseCase(getVietmapApiRepositories()).call(params);
  }
}
