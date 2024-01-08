/// vietmap_flutter_plugin
library vietmap_flutter_plugin;

/// Get Vietmap instance, use this to call all methods
export 'src/di/vietmap_context.dart' show Vietmap;

/// Input params for VietmapAutoComplete method
export 'src/domain/entities/vietmap_autocomplete_params.dart'
    show VietMapAutoCompleteParams;

/// Input params for VietmapRouting method
export 'src/domain/entities/vietmap_routing_params.dart'
    show VietMapRoutingParams, VehicleType;

/// LatLng class, use this to create LatLng object
export 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    show LatLng;

export 'src/utilities/util.dart' show VietmapUtils;

export 'src/core/failures/api_server_failure.dart' show ApiServerFailure;
export 'src/core/failures/api_timeout_failure.dart' show ApiTimeOutFailure;
export 'src/core/failures/apikey_limited_failure.dart'
    show APIKeyLimitedFailure;
export 'src/core/failures/exception_failure.dart' show ExceptionFailure;
export 'src/core/failures/failure.dart' show Failure;
export 'src/core/failures/not_found_failure.dart' show NotFoundFailure;
export 'src/core/enums/failure_enum.dart' show FailureCode;

export 'src/data/models/vietmap_autocomplete_model.dart'
    show VietmapAutocompleteModel;
export 'src/data/models/vietmap_routing_model.dart' show VietMapRoutingModel;
export 'src/data/models/vietmap_place_model.dart' show VietmapPlaceModel;
export 'src/data/models/vietmap_reverse_model.dart' show VietmapReverseModel;

export 'package:dartz/dartz.dart' show Either, Left, Right;

export 'src/core/use_case.dart' show UseCase;
export 'src/core/no_params.dart' show NoParams;
export 'src/core/debounce.dart' show Debounce;
export 'src/extension/latlng_extension.dart' show LatLngExtension;
export 'src/extension/string_extension.dart' show StringExtension;

export 'src/domain/entities/vietmap_model.dart' show VietmapModel;
export 'src/domain/entities/vietmap_routing.dart'
    show VietMapRouting, Paths, Instructions;
