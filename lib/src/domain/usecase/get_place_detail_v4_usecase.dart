import 'package:vietmap_flutter_plugin/src/data/repository/vietmap_api_repository.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class GetPlaceDetailV4Usecase extends UseCase<VietmapPlaceModel, String> {
  final VietmapApiRepository repository;

  GetPlaceDetailV4Usecase(this.repository);

  @override
  Future<Either<Failure, VietmapPlaceModel>> call(String params) async {
    return await repository.getPlaceDetailLocation(params);
  }
}
