// Enum for failure code
enum FailureCode {
  /// [apiFailure] is the failure status that is response while api is not available
  apiFailure,

  /// [networkFailure] is the failure status that is response while network is not available
  networkFailure,

  /// [cacheFailure] is the failure status that is response while cache is not available
  cacheFailure,

  /// [unknownFailure] is the failure status that is response while unknown error
  unknownFailure,

  /// [serverFailure] is the failure status that is response while server error
  serverFailure,

  /// [invalidInputFailure] is the failure status that is response while input is invalid
  invalidInputFailure,

  /// [limitExceedFailure] is the failure status that is response while limit is exceed
  limitExceedFailure,
}
