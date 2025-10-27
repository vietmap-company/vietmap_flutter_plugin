import 'package:vietmap_flutter_plugin/src/data/repository/vietmap_api_repository.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class GeocodeV4Usecase extends UseCase<List<VietmapAutocompleteModel>,
    VietmapAutocompleteParamsV4> {
  final VietmapApiRepository repository;

  GeocodeV4Usecase(this.repository);

  @override
  Future<Either<Failure, List<VietmapAutocompleteModelV4>>> call(
      VietmapAutocompleteParamsV4 params) {
    return repository.geoCodeV4(params);
  }
}
