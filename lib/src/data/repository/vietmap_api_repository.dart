import 'package:vietmap_flutter_plugin/src/data/models/vietmap_matrix_model.dart';
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
  Future<Either<Failure, VietmapReverseModel>> getLocationFromLatLng(
      {required double lat, required double long});
  // Get location from address
  Future<Either<Failure, List<VietmapAutocompleteModel>>> searchLocation(
      VietMapAutoCompleteParams params);
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
