import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:vietmap_flutter_plugin/src/core/enums/failure_enum.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_params.dart';
import 'package:vietmap_flutter_plugin/src/extension/latlng_extension.dart';
import 'package:vietmap_flutter_plugin/src/extension/string_extension.dart';
import '../../core/failures/api_server_failure.dart';
import '../../core/failures/api_timeout_failure.dart';
import '../../core/failures/apikey_limited_failure.dart';
import '../../core/failures/exception_failure.dart';
import '../../core/failures/failure.dart';
import '../../data/models/vietmap_autocomplete_model.dart';
import '../../data/models/vietmap_place_model.dart';
import '../../data/models/vietmap_reverse_model.dart';
import '../../data/models/vietmap_routing_model.dart';
import '../../data/repository/vietmap_api_repository.dart';
import '../../di/vietmap_context.dart';
import '../entities/vietmap_routing_params.dart';

class VietmapApiRepositories implements VietmapApiRepository {
  late Dio _dio;
  String baseUrl = Vietmap.getVietmapBaseUrl();
  String apiKey = Vietmap.getVietmapAPIKey();
  VietmapApiRepositories() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  @override
  Future<Either<Failure, VietmapReverseModel>> getLocationFromLatLng(
      {required double lat, required double long}) async {
    try {
      var res = await _dio.get('reverse/v3',
          queryParameters: {'apikey': apiKey, 'lat': lat, 'lng': long});

      if (res.statusCode == 200 && res.data.length > 0) {
        var data = VietmapReverseModel.fromJson(res.data[0]);
        return Right(data);
      } else if (res.statusCode == 429) {
        return Left(APIKeyLimitedFailure(
            message: 'API key đã đạt giới hạn lượng truy cập hôm nay',
            code: FailureCode.limitExceedFailure));
      } else {
        return const Left(ApiServerFailure('Có lỗi xảy ra'));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }

  @override
  Future<Either<Failure, List<VietmapAutocompleteModel>>> searchLocation(
      VietMapAutoCompleteParams params) async {
    try {
      Map<String, dynamic> queryParams = {
        'apikey': apiKey,
        'text': params.textSearch
      };
      if (params.focusLocation != null) {
        queryParams['focus'] = params.focusLocation!.toUrlValue();
      }
      var res = await _dio.get('autocomplete/v3', queryParameters: queryParams);

      if (res.statusCode == 200) {
        var data = List<VietmapAutocompleteModel>.from(
            res.data.map((e) => VietmapAutocompleteModel.fromJson(e)));
        return Right(data);
      } else if (res.statusCode == 429) {
        return Left(APIKeyLimitedFailure(
            message: 'API key đã đạt giới hạn lượng truy cập hôm nay',
            code: FailureCode.limitExceedFailure));
      } else {
        return const Left(ApiServerFailure('Có lỗi xảy ra'));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }

  @override
  Future<Either<Failure, VietmapPlaceModel>> getPlaceDetail(
      String placeId) async {
    try {
      var res = await _dio.get('place/v3',
          queryParameters: {'apikey': apiKey, 'refid': placeId});

      if (res.statusCode == 200) {
        var data = VietmapPlaceModel.fromJson(res.data);
        return Right(data);
      } else if (res.statusCode == 429) {
        return Left(APIKeyLimitedFailure(
            message: 'API key đã đạt giới hạn lượng truy cập hôm nay',
            code: FailureCode.limitExceedFailure));
      } else {
        return const Left(ApiServerFailure('Có lỗi xảy ra'));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }

  @override
  Future<Either<Failure, VietMapRoutingModel>> findRoute(
      VietMapRoutingParams params) async {
    try {
      String path = params.toMap(apiKey).toString();

      path = path.convertJsonToUrlPath();
      for (var element in params.points) {
        path += '&point=${element.toUrlValue()}';
      }

      var res = await _dio.get('route?$path');
      if (res.statusCode == 200) {
        var data = VietMapRoutingModel.fromJson(res.data);
        return Right(data);
      } else if (res.statusCode == 429) {
        return Left(APIKeyLimitedFailure(
            message: 'API key đã đạt giới hạn lượng truy cập hôm nay',
            code: FailureCode.limitExceedFailure));
      } else {
        return const Left(ApiServerFailure('Có lỗi xảy ra'));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }

  @override
  Future<Either<Failure, List<VietmapAutocompleteModel>>> geoCode(
      VietMapAutoCompleteParams params) async {
    try {
      Map<String, dynamic> queryParams = {
        'apikey': apiKey,
        'text': params.textSearch
      };
      if (params.focusLocation != null) {
        queryParams['focus'] = params.focusLocation!.toUrlValue();
      }
      var res = await _dio.get('autocomplete/v3', queryParameters: queryParams);

      if (res.statusCode == 200) {
        var data = List<VietmapAutocompleteModel>.from(
            res.data.map((e) => VietmapAutocompleteModel.fromJson(e)));
        return Right(data);
      } else if (res.statusCode == 429) {
        return Left(APIKeyLimitedFailure(
            message: 'API key đã đạt giới hạn lượng truy cập hôm nay',
            code: FailureCode.limitExceedFailure));
      } else {
        return const Left(ApiServerFailure('Có lỗi xảy ra'));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }
}
