import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/repository/vietmap_api_repositories.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class AutocompleteLocationUsecase
    extends UseCase<List<VietmapAutocompleteModel>, VietmapAutocompleteParamsV4> {
  final VietmapApiRepositories repository;

  AutocompleteLocationUsecase(this.repository);

  @override
  Future<Either<Failure, List<VietmapAutocompleteModelV4>>> call(
      VietmapAutocompleteParamsV4 params) {
    return repository.autocompleteLocation(params);
  }
}
