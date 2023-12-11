import 'failure.dart';

// ApiServerFailure is a failure class that is used when the server returns
// [500 error code].
class ApiServerFailure extends Failure {
  /// [message] is the error message that is returned from the server.
  final String message;
  const ApiServerFailure(this.message);
}
