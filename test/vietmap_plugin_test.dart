import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vietmap_flutter_plugin/src/core/enums/autocomplete_display_type.dart';
import 'package:vietmap_flutter_plugin/src/data/models/vietmap_autocomplete_model_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_param_v4.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  String? apikey = dotenv.env['VIETMAP_API_KEY'];
  group('Test Vietmap APIs', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    // test('Test autocomplete function', () async {
    //   var res = await Vietmap.autocomplete(
    //       VietMapAutoCompleteParams(textSearch: 'Vietmap'));
    //   res.fold(
    //       (l) => false,
    //       (r) =>
    //           expect(r, const TypeMatcher<List<VietmapAutocompleteModel>>()));
    // });

    // test('Test autocomplete v4 function', () async {
    //   var res = await Vietmap.autocompleteV4(VietmapAutocompleteParamsV4(
    //     text: 'Bản đồ việt',
    //     displayType: AutocompleteDisplayType.newFormat.value,
    //   ));
    //   res.fold((l) {
    //     debugPrint((l as ExceptionFailure).message.toString());
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toString());
    //     expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>());
    //   });
    // });

    test('Test autocomplete v4 function without display type', () async {
      var res = await Vietmap.autocompleteV4(VietmapAutocompleteParamsV4(
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

    // test('Test geocode function', () async {
    //   var res = await Vietmap.geoCode(
    //       VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    //   res.fold(
    //       (l) => false,
    //       (r) =>
    //           expect(r, const TypeMatcher<List<VietmapAutocompleteModel>>()));
    // });

    // test('Test matrix function', () async {
    //   var res = await Vietmap.matrix(VietmapMatrixParams(points: [
    //     const LatLng(10.768897, 106.678505),
    //     const LatLng(10.765496, 106.67626),
    //     const LatLng(10.7627936, 106.6750729),
    //     const LatLng(10.7616745, 106.6792425),
    //     const LatLng(10.765605, 106.685383),
    //   ], sourcePoints: [
    //     0,
    //     1
    //   ], destinationPoints: [
    //     2,
    //     3,
    //     4
    //   ]));

    //   res.fold((l) => false, (r) {
    //     expect(r, const TypeMatcher<VietmapMatrixModel>());
    //   });
    // });
    // test('Test reverse function', () async {
    //   var res = await Vietmap.reverse(const LatLng(21.027763, 105.834160));
    //   res.fold((l) => false, (r) => expect(r, isA<VietmapReverseModel>()));
    // });

    // test('Test reverse function without display type', () async {
    //   var res = await Vietmap.reverse(
    //       const LatLng(17.182067933976644, 106.84040360974664));
    //   res.fold((l) {
    //     debugPrint(l.toString());
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toJson().toString());
    //     expect(r, isA<VietmapReverseModel>());
    //   });
    // });

    // test('Test reverse v1 function without display type', () async {
    //   var res = await Vietmap.reverseV4(VietmapReverseParams(
    //     latLng: const LatLng(17.182067933976644, 106.84040360974664),
    //   ));
    //   res.fold((l) {
    //     debugPrint(l.toString());
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toJson().toString());
    //     expect(r, isA<VietmapReverseModel>());
    //   });
    // });

    // test('Test reverse v1 function with display type', () async {
    //   var res = await Vietmap.reverseV4(VietmapReverseParams(
    //     latLng: const LatLng(17.182067933976644, 106.84040360974664),
    //     displayType: ReverseDisplayType.newFormat.value,
    //   ));
    //   res.fold((l) {
    //     debugPrint(l.toString());
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toJson().toString());
    //     expect(r, isA<VietmapReverseModel>());
    //   });
    // });

    // test('Test reverse v1 function with invalid display type', () async {
    //   var res = await Vietmap.reverseV4(VietmapReverseParams(
    //     latLng: const LatLng(17.182067933976644, 106.84040360974664),
    //     displayType: 10,
    //   ));
    //   res.fold((l) {
    //     debugPrint('=====${(l as ExceptionFailure).message.toString()}');
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toJson().toString());
    //     expect(r, isA<VietmapReverseModel>());
    //   });
    // });

    // test('Test reverse v1 function with latlng out of range viet nam',
    //     () async {
    //   var res = await Vietmap.reverseV4(VietmapReverseParams(
    //     latLng: const LatLng(-13.2329283354478, 30.23900595311518),
    //     displayType: 10,
    //   ));
    //   res.fold((l) {
    //     debugPrint('=====${(l as ExceptionFailure).message.toString()}');
    //     return false;
    //   }, (r) {
    //     debugPrint(r.toJson().toString());
    //     expect(r, isA<VietmapReverseModel>());
    //   });
    // });

    // test('Test place function', () async {
    //   var res = await Vietmap.place('Place ID');
    //   res.fold((l) => false, (r) {
    //     expect(r, isA<VietmapPlaceModel>());
    //   });
    // });
    // test('Test routing function', () async {
    //   var res = await Vietmap.routing(VietMapRoutingParams(points: [
    //     const LatLng(10.779391, 106.624833),
    //     const LatLng(10.741039, 106.672116)
    //   ]));
    //   res.fold((l) => false, (r) => expect(r, isA<VietMapRoutingModel>()));
    // });
    // test('Test getVietmapStyleUrl function', () async {
    //   var res = Vietmap.getVietmapStyleUrl();
    //   expect(res, isNotEmpty);
    // });
    // test('Test getVietmapBaseUrl function', () async {
    //   var res = Vietmap.getVietmapBaseUrl();
    //   expect(res, isNotEmpty);
    // });
  });
}
