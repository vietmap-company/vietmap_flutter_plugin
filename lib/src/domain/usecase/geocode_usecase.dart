import 'package:dartz/dartz.dart';
import 'package:vietmap_plugin/src/domain/entities/vietmap_autocomplete_params.dart';

import '../../core/failures/failure.dart';
import '../../core/use_case.dart';
import '../../data/models/vietmap_autocomplete_model.dart';
import '../../data/repository/vietmap_api_repository.dart';

class GeoCodeUseCase
    extends UseCase<List<VietmapAutocompleteModel>, VietMapAutoCompleteParams> {
  final VietmapApiRepository repository;

  GeoCodeUseCase(this.repository);
  @override
  Future<Either<Failure, List<VietmapAutocompleteModel>>> call(
      VietMapAutoCompleteParams params) {
    return repository.geoCode(params);
  }
}
