import 'package:vietmap_plugin/src/domain/entities/vietmap_autocomplete_params.dart';

import '../../core/failures/failure.dart';
import '../../domain/entities/vietmap_routing_params.dart';
import '../models/vietmap_place_model.dart';

import 'package:dartz/dartz.dart';

import '../models/vietmap_autocomplete_model.dart';
import '../models/vietmap_reverse_model.dart';
import '../models/vietmap_routing_model.dart';

abstract class VietmapApiRepository {
  Future<Either<Failure, VietmapReverseModel>> getLocationFromLatLng(
      {required double lat, required double long});

  Future<Either<Failure, List<VietmapAutocompleteModel>>> searchLocation(
      VietMapAutoCompleteParams params);

  Future<Either<Failure, VietmapPlaceModel>> getPlaceDetail(String placeId);

  Future<Either<Failure, VietMapRoutingModel>> findRoute(
      VietMapRoutingParams params);

  Future<Either<Failure, List<VietmapAutocompleteModel>>> geoCode(
    VietMapAutoCompleteParams params,
  );
}
