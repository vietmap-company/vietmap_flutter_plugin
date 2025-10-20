import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vietmap_flutter_plugin/src/core/enums/autocomplete_display_type.dart';
import 'package:vietmap_flutter_plugin/src/core/enums/migrate_type.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_migrate_address_model.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_migrate_address_params.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  String? apikey = dotenv.env['VIETMAP_API_KEY'];

  group('Test Vietmap APIs', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    test('Test autocomplete function', () async {
      var res = await Vietmap.autocomplete(
          VietMapAutoCompleteParams(textSearch: 'Vietmap'));
      res.fold(
          (l) => false,
          (r) =>
              expect(r, const TypeMatcher<List<VietmapAutocompleteModel>>()));
    });

    test('Test geocode function', () async {
      var res = await Vietmap.geoCode(
          VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
      res.fold(
          (l) => false,
          (r) =>
              expect(r, const TypeMatcher<List<VietmapAutocompleteModel>>()));
    });

    test('Test matrix function', () async {
      var res = await Vietmap.matrix(VietmapMatrixParams(points: [
        const LatLng(10.768897, 106.678505),
        const LatLng(10.765496, 106.67626),
        const LatLng(10.7627936, 106.6750729),
        const LatLng(10.7616745, 106.6792425),
        const LatLng(10.765605, 106.685383),
      ], sourcePoints: [
        0,
        1
      ], destinationPoints: [
        2,
        3,
        4
      ]));

      res.fold((l) => false, (r) {
        expect(r, const TypeMatcher<VietmapMatrixModel>());
      });
    });
    test('Test reverse function', () async {
      var res = await Vietmap.reverse(const LatLng(21.027763, 105.834160));
      res.fold((l) => false, (r) => expect(r, isA<VietmapReverseModel>()));
    });
    test('Test place function', () async {
      var res = await Vietmap.place('Place ID');
      res.fold((l) => false, (r) => expect(r, isA<VietmapPlaceModel>()));
    });
    test('Test routing function', () async {
      var res = await Vietmap.routing(VietMapRoutingParams(points: [
        const LatLng(10.779391, 106.624833),
        const LatLng(10.741039, 106.672116)
      ]));
      res.fold((l) => false, (r) => expect(r, isA<VietMapRoutingModel>()));
    });
    test('Test getVietmapStyleUrl function', () async {
      var res = Vietmap.getVietmapStyleUrl();
      expect(res, isNotEmpty);
    });
    test('Test getVietmapBaseUrl function', () async {
      var res = Vietmap.getVietmapBaseUrl();
      expect(res, isNotEmpty);
    });
  });

  group('Test Vietmap Search(Geocode) APIs v4', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    test('Test search v4 function without display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Bản đồ việt',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for all display types
    test('Test geoCodeV4 with newFormat display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Công Ty Cổ Phần Ứng Dụng Bản Đồ Việt',
        displayType: AutocompleteDisplayType.newFormat.value,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with oldFormat display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Hà Nội',
        displayType: AutocompleteDisplayType.oldFormat.value,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with asInputFormat display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Tp Hồ Chí Minh',
        displayType: AutocompleteDisplayType.asInputFormat.value,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with bothNewAndOld display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Đà Nẵng',
        displayType: AutocompleteDisplayType.bothNewAndOld.value,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with bothOldAndNew display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Cần Thơ',
        displayType: AutocompleteDisplayType.bothOldAndNew.value,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for focus location with LatLng
    test('Test geoCodeV4 with focus location', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'cafe',
        focusLocation: const LatLng(10.759540242000032, 106.67660114000005),
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for different layer types
    test('Test geoCodeV4 with POI layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'restaurant',
        layers: 'POI',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with ADDRESS layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'số 123',
        layers: 'ADDRESS',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with VILLAGE layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'thôn',
        layers: 'VILLAGE',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with WARD layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'phường',
        layers: 'WARD',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with DIST layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'quận',
        layers: 'DIST',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with CITY layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'thành phố',
        layers: 'CITY',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with STREET layer only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'đường',
        layers: 'STREET',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with multiple layers', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Hà Nội',
        layers: 'POI,ADDRESS,STREET,CITY',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with all layers', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        layers: 'POI,ADDRESS,VILLAGE,WARD,DIST,CITY,STREET',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for circle search with different radius values
    test('Test geoCodeV4 with small circle radius (100m)', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'cafe',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 100,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with medium circle radius (500m)', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'ATM',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 500,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with large circle radius (5km)', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'hospital',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 5000,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for POI categories
    test('Test geoCodeV4 with food category', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'phở',
        cats: '1002-1',
        layers: 'POI',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with multiple POI categories', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'service',
        cats: '1002-1,1003-1,1004-1',
        layers: 'POI',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases for administrative filters (city, district, ward)
    test('Test geoCodeV4 with Ho Chi Minh City filter', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'công viên',
        cityId: 12, // Ho Chi Minh City ID
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with Hanoi City filter', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'trường học',
        cityId: 1, // Hanoi City ID
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with city and district filter', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'bệnh viện',
        cityId: 12,
        distId: 1292,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with city, district, and ward filter', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'siêu thị',
        cityId: 12,
        distId: 1292,
        wardId: 984332,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Test cases with all parameters combined
    test('Test geoCodeV4 with maximum parameters combination', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Công Ty Cổ Phần Ứng Dụng Bản Đồ Việt',
        focusLocation: const LatLng(10.759540242000032, 106.67660114000005),
        displayType: AutocompleteDisplayType.newFormat.value,
        layers: 'POI,ADDRESS',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 1000,
        cats: '1002-1',
        cityId: 12,
        distId: 1292,
        wardId: 984332,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Edge cases and error handling
    test('Test geoCodeV4 with empty text - should fail', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: '',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        fail('Should fail with empty text');
      });
    });

    test('Test geoCodeV4 with null text - should fail', () async {
      try {
        var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
          text: null as dynamic,
        ));
        fail('Should throw exception with null text');
      } catch (e) {
        expect(e, isA<TypeError>());
      }
    });

    test('Test geoCodeV4 with very long text', () async {
      var longText =
          'Công Ty Cổ Phần Ứng Dụng Bản Đồ Việt Nam Với Tên Rất Dài Để Test Giới Hạn Của API ' *
              10;
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: longText,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with special characters', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: '!@#\$%^&*()_+-=[]{}|;:,.<>?',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with Unicode characters', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: '北京市 东京都 서울특별시',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        displayType: 999, // Invalid display type
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with negative circle radius', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: -100,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with zero circle radius', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 0,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with extremely large circle radius', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        circleRadius: 1000000, // 1000km
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid coordinates (out of Vietnam)', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleCenter: const LatLng(0, 0), // Invalid coordinates for Vietnam
        circleRadius: 1000,
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid focus location', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        focusLocation: const LatLng(999, 999), // Invalid coordinates
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid cityId', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        cityId: -1, // Invalid city ID
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid distId without cityId', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        distId: 1292, // District ID without city ID
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid wardId without distId', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        cityId: 12,
        wardId: 984332, // Ward ID without district ID
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid layer name', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        layers: 'INVALID_LAYER',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with invalid cats format', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        cats: 'invalid-format',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with circle center but no radius', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleCenter: const LatLng(10.758867051669924, 106.6755666901197),
        // No circle radius specified
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with circle radius but no center', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'test',
        circleRadius: 1000,
        // No circle center specified
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    // Performance and stress tests
    test('Test geoCodeV4 with multiple rapid calls', () async {
      List<Future> futures = [];
      for (int i = 0; i < 5; i++) {
        futures.add(Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
          text: 'test $i',
        )));
      }

      var results = await Future.wait(futures);
      for (var result in results) {
        result.fold(
          (l) => debugPrint((l as ExceptionFailure).message.toString()),
          (r) =>
              expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>()),
        );
      }
    });

    // Test different Vietnamese text formats
    test('Test geoCodeV4 with Vietnamese with diacritics', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Trường Đại học Bách khoa Hà Nội',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with Vietnamese without diacritics', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'Truong Dai hoc Bach khoa Ha Noi',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with mixed case text', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'hA nOi',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with numbers in text', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'số 123 đường ABC',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with single character', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'H',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test geoCodeV4 with whitespace only', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: '   ',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        expect(l, isA<ExceptionFailure>());
      }, (r) {
        fail('Should fail with whitespace only text');
      });
    });
  });

  group('Test Vietmap Place API v4', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    List<VietmapAutocompleteModelV4> responses = [];

    test('Test search v4 function without display type', () async {
      var res = await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(
        text: 'thôn đông thiện',
      ));
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        responses = r;
        expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
      });
    });

    test('Test place v4 function with empty refId', () async {
      var res = await Vietmap.placeV4(' ');
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, isA<VietmapPlaceModel>());
      });
    });

    test('Test place v4 function', () async {
      for (VietmapAutocompleteModelV4 i in responses) {
        var res = await Vietmap.placeV4(i.refId ?? '');
        res.fold((l) {
          debugPrint((l as ExceptionFailure).message.toString());
          return false;
        }, (r) {
          debugPrint(r.toString());
          expect(r, isA<VietmapPlaceModel>());
        });
      }
    });
  });

  group('Test Vietmap Migrate Address API v3', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    test('Test migrate address function', () async {
      var res = await Vietmap.migrateAddress(
        VietmapMigrateAddressParams(
          text: 'Dương Thuỷ - Lệ Thuỷ',
          migrateType: MigrateType.oldToNew.value,
        ),
      );
      res.fold((l) {
        debugPrint((l as ExceptionFailure).message.toString());
        return false;
      }, (r) {
        debugPrint(r.toString());
        expect(r, const TypeMatcher<VietmapMigrateAddressModel>());
      });
    });
  });
}
