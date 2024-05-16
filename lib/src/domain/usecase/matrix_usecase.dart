import 'package:dartz/dartz.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_matrix_model.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_matrix_params.dart';

import '../../core/failures/failure.dart';
import '../../core/use_case.dart';
import '../../data/repository/vietmap_api_repository.dart';

class MatrixUseCase extends UseCase<VietmapMatrixModel, VietmapMatrixParams> {
  final VietmapApiRepository repository;

  MatrixUseCase(this.repository);
  @override
  Future<Either<Failure, VietmapMatrixModel>> call(VietmapMatrixParams params) {
    return repository.matrix(params);
  }
}
