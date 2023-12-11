import 'package:vietmap_flutter_plugin/src/core/enums/failure_enum.dart';

import 'failure.dart';

// APIKeyLimitedFailure is a failure class that is used when the server returns
// [429 error code].
class APIKeyLimitedFailure extends Failure {
  /// [message] is the error message that is returned from the server.
  final String message;

  /// [code] is the error code that is returned from the server.
  final FailureCode code;

  APIKeyLimitedFailure({required this.message, required this.code});
}
