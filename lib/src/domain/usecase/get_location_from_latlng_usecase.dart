import 'package:dartz/dartz.dart';
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

import '../../core/failures/failure.dart';
import '../../core/use_case.dart';
import '../../data/models/vietmap_reverse_model.dart';
import '../../data/repository/vietmap_api_repository.dart';

class GetLocationFromLatLngUseCase
    extends UseCase<VietmapReverseModel, LatLng> {
  final VietmapApiRepository repository;

  GetLocationFromLatLngUseCase(this.repository);
  @override
  Future<Either<Failure, VietmapReverseModel>> call(LatLng params) {
    return repository.getLocationFromLatLng(
        lat: params.latitude, long: params.longitude);
  }
}
