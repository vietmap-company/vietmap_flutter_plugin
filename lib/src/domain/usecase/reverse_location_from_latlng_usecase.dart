import 'package:vietmap_flutter_plugin/src/data/models/vietmap_reverse_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_reverse_params.dart';
import 'package:vietmap_flutter_plugin/src/domain/repository/vietmap_api_repositories.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class ReverseLocationFromLatlngUsecase
    extends UseCase<VietmapReverseModel, VietmapReverseParams> {
  final VietmapApiRepositories repository;

  ReverseLocationFromLatlngUsecase(this.repository);

  @override
  Future<Either<Failure, VietmapReverseModelV4>> call(
      VietmapReverseParams params) {
    return repository.reverseLocationFromLatLng(
      lat: params.latLng.latitude,
      long: params.latLng.longitude,
      displayType: params.displayType,
    );
  }
}
