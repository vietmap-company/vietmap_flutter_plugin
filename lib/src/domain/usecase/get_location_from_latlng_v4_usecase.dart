import 'package:vietmap_flutter_plugin/src/data/repository/vietmap_api_repository.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class GetLocationFromLatlngV4Usecase
    extends UseCase<VietmapReverseModelV4, VietmapReverseParams> {
  final VietmapApiRepository repository;

  GetLocationFromLatlngV4Usecase(this.repository);

  @override
  Future<Either<Failure, VietmapReverseModelV4>> call(
      VietmapReverseParams params) {
    return repository.getLocationFromLatLngV4(
      params,
    );
  }
}
