import 'package:dartz/dartz.dart';
import 'package:vietmap_flutter_plugin/src/core/failures/failure.dart';
import 'package:vietmap_flutter_plugin/src/core/use_case.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/data/repository/vietmap_api_repository.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_params_v4.dart';

class SearchAddressV4Usecase extends UseCase<List<VietmapAutocompleteModelV4>,
    VietmapAutocompleteParamsV4> {
  final VietmapApiRepository repository;

  SearchAddressV4Usecase(this.repository);

  @override
  Future<Either<Failure, List<VietmapAutocompleteModelV4>>> call(
      VietmapAutocompleteParamsV4 params) async {
    return await repository.searchLocationV4(params);
  }
}
