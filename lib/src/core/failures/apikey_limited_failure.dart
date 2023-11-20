import 'package:vietmap_flutter_plugin/src/core/enums/failure_enum.dart';

import 'failure.dart';

class APIKeyLimitedFailure extends Failure {
  final String message;
  final FailureCode code;

  APIKeyLimitedFailure({required this.message, required this.code});
}
