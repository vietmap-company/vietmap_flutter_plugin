import 'package:dartz/dartz.dart';
import 'package:vietmap_flutter_plugin/src/core/failures/failure.dart';
import 'package:vietmap_flutter_plugin/src/core/use_case.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_migrate_address_model.dart';
import 'package:vietmap_flutter_plugin/src/data/repository/vietmap_api_repository.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_migrate_address_params.dart';

class MigrateAddressUsecase
    extends UseCase<VietmapMigrateAddressModel, VietmapMigrateAddressParams> {
  final VietmapApiRepository repository;

  MigrateAddressUsecase(this.repository);

  @override
  Future<Either<Failure, VietmapMigrateAddressModel>> call(
      VietmapMigrateAddressParams params) async {
    return await repository.migrateAddress(params);
  }
}
