import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_matrix_model.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_reverse_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_params.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_matrix_params.dart';

import '../../core/failures/failure.dart';
import '../../domain/entities/vietmap_routing_params.dart';
import '../models/vietmap_place_model.dart';

import 'package:dartz/dartz.dart';

import '../models/vietmap_autocomplete_model.dart';
import '../models/vietmap_reverse_model.dart';
import '../models/vietmap_routing_model.dart';

// VietmapApiRepository is an abstract class that is used to define the Vietmap
// API repository.
abstract class VietmapApiRepository {
  // Get location from lat, long
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use reverseLocationFromLatLng instead. See https://maps.vietmap.vn/docs/map-api/reverse-version/reverse-v4/')
  Future<Either<Failure, VietmapReverseModel>> getLocationFromLatLng(
      {required double lat, required double long});

  // Get location from lat, long (VietMap Reverse API v4)
  Future<Either<Failure, VietmapReverseModelV4>> reverseLocationFromLatLng(
      {required double lat, required double long, int? displayType});

  // Get location from address
  @Deprecated(
      'Migrate VietMap API from v3 to v4. Use autocompleteLocation instead. See https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4/')
  Future<Either<Failure, List<VietmapAutocompleteModel>>> searchLocation(
      VietMapAutoCompleteParams params);

  Future<Either<Failure, List<VietmapAutocompleteModelV4>>> autocompleteLocation(
      VietmapAutocompleteParamsV4 params);

  // Get place detail from place id
  Future<Either<Failure, VietmapPlaceModel>> getPlaceDetail(String placeId);

  // Get direction from origin to destination
  Future<Either<Failure, VietMapRoutingModel>> findRoute(
      VietMapRoutingParams params);

  // Get autocomplete from address
  Future<Either<Failure, List<VietmapAutocompleteModel>>> geoCode(
    VietMapAutoCompleteParams params,
  );

  /// Get matrix api from vietmap
  Future<Either<Failure, VietmapMatrixModel>> matrix(
    VietmapMatrixParams params,
  );
}
