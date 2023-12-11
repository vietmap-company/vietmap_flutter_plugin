import 'failure.dart';

class ExceptionFailure extends Failure {
  /// [message] is the error message that is returned from the server.
  final Exception message;
  const ExceptionFailure(this.message);
}
