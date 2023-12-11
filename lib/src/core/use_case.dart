import 'package:dartz/dartz.dart';

import 'failures/failure.dart';

/// UseCase is an abstract class that is used to define a use case.
abstract class UseCase<Type, Params> {
  /// [call] is the method that is used to call the use case.
  Future<Either<Failure, Type>> call(Params params);
}
