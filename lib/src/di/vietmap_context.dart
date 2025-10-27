import 'package:vietmap_flutter_plugin/src/domain/repository/vietmap_api_repositories.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/geocode_v4_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/geocode_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/get_location_from_latlng_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/get_place_detail_v4_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/matrix_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/migrate_address_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/get_location_from_latlng_v4_usecase.dart';
import 'package:vietmap_flutter_plugin/src/domain/usecase/search_address_v4_usecase.dart';

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

  /// Get vietmap style url based on TileMapEnum. See [TileMapEnum] for more details.
  static String getMapStyle({TileMapEnum? type}) {
    if (_vietmapAPIKey.isEmpty) {
      throw Exception('Please call `Vietmap.getInstance(apiKey)` before use');
    }
    switch (type) {
      case TileMapEnum.vectorDefault:
        return 'https://maps.vietmap.vn/maps/styles/tm/style.json?apikey=$_vietmapAPIKey';
      case TileMapEnum.vectorLight:
        return 'https://maps.vietmap.vn/maps/styles/lm/style.json?apikey=$_vietmapAPIKey';
      case TileMapEnum.vectorDark:
        return 'https://maps.vietmap.vn/maps/styles/dm/style.json?apikey=$_vietmapAPIKey';
      case TileMapEnum.rasterDefault:
        return 'https://maps.vietmap.vn/maps/styles/tm/tiles.json?apikey=$_vietmapAPIKey';
      case TileMapEnum.rasterLight:
        return 'https://maps.vietmap.vn/maps/styles/lm/tiles.json?apikey=$_vietmapAPIKey';
      case TileMapEnum.rasterDark:
        return 'https://maps.vietmap.vn/maps/styles/dm/tiles.json?apikey=$_vietmapAPIKey';
      default:
        return 'https://maps.vietmap.vn/maps/styles/tm/style.json?apikey=$_vietmapAPIKey';
    }
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

  /// Autocomplete V4 API provides location suggestions based on user input.
  /// This API is designed to help users quickly find and select locations
  /// by suggesting potential matches as they type, enhancing the user experience
  /// in location-based applications.
  /// See more at https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4
  static Future<Either<Failure, List<VietmapAutocompleteModelV4>>>
      autocompleteV4(VietmapAutocompleteParamsV4 params) {
    return SearchAddressV4Usecase(getVietmapApiRepositories()).call(params);
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

  /// Reverse V4 API is a demonstration version of the reverse geocoding service
  /// that allows developers to test and explore location search features.
  /// This API provides a way to convert geographic coordinates (latitude and longitude) into readable addresses and location information,
  /// helping developers understand the capabilities before implementing the full version.
  /// See more at https://maps.vietmap.vn/docs/map-api/reverse-version/reverse-v4.
  static Future<Either<Failure, VietmapReverseModelV4>> reverseV4(
      VietmapReverseParams params) {
    return GetLocationFromLatlngV4Usecase(getVietmapApiRepositories())
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
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use autocomplete instead. See https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4')
  static Future<Either<Failure, VietmapPlaceModel>> place(String placeId) {
    return GetPlaceDetailUseCase(getVietmapApiRepositories()).call(placeId);
  }

  /// The Place API service endpoint provides detailed information about the Place found by its identifier (refid).
  /// See more at https://maps.vietmap.vn/docs/map-api/place-v4
  static Future<Either<Failure, VietmapPlaceModel>> placeV4(String refId) {
    return GetPlaceDetailV4Usecase(getVietmapApiRepositories()).call(refId);
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
  // performance. Additionally, this latest version utilizes intelligent search
  // algorithms and methods to provide accurate and speedy search results for users.
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use autocomplete instead. See https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4')
  static Future<Either<Failure, List<VietmapAutocompleteModel>>> geoCode(
      VietMapAutoCompleteParams params) {
    return GeoCodeUseCase(getVietmapApiRepositories()).call(params);
  }

  /// Retrieves a list of locations based on the provided address input.
  /// Upgraded from the Geocode v3 API, version 4 offers enhanced performance
  /// and provides a more powerful solution for developers to integrate
  /// location search functionality into their applications.
  /// See more at https://maps.vietmap.vn/docs/map-api/geocode-version/geocode-v4
  static Future<Either<Failure, List<VietmapAutocompleteModelV4>>> geoCodeV4(
      VietmapAutocompleteParamsV4 params) {
    return GeocodeV4Usecase(getVietmapApiRepositories()).call(params);
  }

  /// Migrate addresses between the old and new standardized formats used by VIETMAP.
  /// This API allows users to input either an old or new address format
  /// and receive a structured response with the corresponding converted address.
  /// See more at https://maps.vietmap.vn/docs/migrate-address/migrate-address-docs
  static Future<Either<Failure, VietmapMigrateAddressModel>> migrateAddress(
      VietmapMigrateAddressParams params) {
    return MigrateAddressUsecase(getVietmapApiRepositories()).call(params);
  }
}
