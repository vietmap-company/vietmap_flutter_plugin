// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:vietmap_flutter_plugin/src/core/enums/failure_enum.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_matrix_model.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_migrate_address_model.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_reverse_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_params.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_matrix_params.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_migrate_address_params.dart';
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
  Future<Either<Failure, VietmapMigrateAddressModel>> migrateAddress(
      VietmapMigrateAddressParams params) async {
    try {
      if (params.text.isEmpty) {
        return Left(ExceptionFailure(
            Exception('Địa chỉ hiện tại không được để trống')));
      }
      if (params.migrateType != null &&
          params.migrateType! == 2 &&
          params.focus == null) {
        return Left(ExceptionFailure(
            Exception('Vui lòng cung cấp tọa độ focus khi migrateType là 2')));
      }
      var res = await _dio.get(
        'migrate-address/v3',
        queryParameters: {'apikey': apiKey, ...params.toQueryParam()},
      );

      if (res.statusCode == 200) {
        var data = VietmapMigrateAddressModel.fromJson(res.data);
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
  Future<Either<Failure, VietmapPlaceModel>> getPlaceDetailLocation(
      String refId) async {
    try {
      if (refId.isEmpty) {
        return Left(ExceptionFailure(Exception('RefId không được để trống')));
      }
      var res = await _dio
          .get('place/v4', queryParameters: {'apikey': apiKey, 'refid': refId});

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
  Future<Either<Failure, List<VietmapAutocompleteModelV4>>> geoCodeLocation(
      VietmapAutocompleteParamsV4 params) async {
    try {
      if (params.textSearch.isEmpty) {
        return const Right([]);
      }
      final queryParams = {'apikey': apiKey, ...params.toQueryParam()};
      var res = await _dio.get(
        'search/v4',
        queryParameters: queryParams,
      );

      if (res.statusCode == 200) {
        var data = List<VietmapAutocompleteModelV4>.from(
            res.data.map((e) => VietmapAutocompleteModelV4.fromJson(e)));
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
  Future<Either<Failure, VietmapReverseModelV4>> reverseLocationFromLatLng(
      {required double lat, required double long, int? displayType}) async {
    try {
      var res = await _dio.get('reverse/v4', queryParameters: {
        'apikey': apiKey,
        'lat': lat,
        'lng': long,
        if (displayType != null) 'display_type': displayType
      });

      if (res.statusCode == 200 && res.data.length > 0) {
        var data = VietmapReverseModelV4.fromJson(res.data[0]);
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
  Future<Either<Failure, List<VietmapAutocompleteModelV4>>>
      autocompleteLocation(VietmapAutocompleteParamsV4 params) async {
    try {
      final queryParams = {'apikey': apiKey, ...params.toQueryParam()};
      var res = await _dio.get(
        'autocomplete/v4',
        queryParameters: queryParams,
      );

      if (res.statusCode == 200) {
        var data = List<VietmapAutocompleteModelV4>.from(
            res.data.map((e) => VietmapAutocompleteModelV4.fromJson(e)));
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
      String path = params.toMap().toString();

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

  @override
  Future<Either<Failure, VietmapMatrixModel>> matrix(
      VietmapMatrixParams params) async {
    try {
      var pointsLength = params.points.length;
      for (var element in params.destinationPoints) {
        if (element > pointsLength - 1) {
          return Left(ExceptionFailure(
              Exception('Invalid input destination point index')));
        }
      }
      for (var element in params.sourcePoints) {
        if (element > pointsLength - 1) {
          return Left(ExceptionFailure(
              Exception('Invalid input destination point index')));
        }
      }
      Map<String, dynamic> queryParams = {
        'apikey': Vietmap.getVietmapAPIKey(),
        'api-version': params.apiVersion,
        'sources': params.sourcePoints.join(';'),
        'destinations': params.destinationPoints.join(';')
      };
      String path = queryParams.toString();
      path = path.convertJsonToUrlPath();
      for (var element in params.points) {
        path += '&point=${element.toUrlValue()}';
      }
      var res = await _dio.get('matrix?$path');

      if (res.statusCode == 200) {
        var data = VietmapMatrixModel.fromJson(res.data);
        if (params.isShowTablePreview && kDebugMode) {
          int i = 0;
          String distanceTableTitle = '         |';
          List<String> distanceTableLine = [];
          int ii = 0;
          List<String> durationTableLine = [];
          for (var element in data.distances ?? []) {
            int j = 0;
            String line = 'Point ${params.sourcePoints[i]}  |';
            for (var e in element) {
              if (i == 0) {
                distanceTableTitle +=
                    '|   Point ${params.destinationPoints[j++]}   |';
              }
              line += '|    $e m   |';
            }
            distanceTableLine.add(line);
            i++;
          }
          for (var element in data.durations ?? []) {
            String line = 'Point ${params.sourcePoints[ii]}  |';
            for (var e in element) {
              line += '|    $e s    |';
            }
            durationTableLine.add(line);
            ii++;
          }

          print('Distance table');
          print('-----------------------------------------------------');
          print(distanceTableTitle);
          for (var element in distanceTableLine) {
            print('-----------------------------------------------------');
            print(element);
          }
          print('-----------------------------------------------------');
          print('Duration table');
          print('-----------------------------------------------------');
          print(distanceTableTitle);
          for (var element in durationTableLine) {
            print('-----------------------------------------------------');
            print(element);
          }
        }
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
