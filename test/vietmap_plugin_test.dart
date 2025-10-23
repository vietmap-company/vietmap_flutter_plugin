import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietmap_flutter_plugin/src/core/enums/tilemap_enum.dart';

import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_autocomplete_params_v4.dart';
import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_migrate_address_params.dart';

import 'package:vietmap_flutter_plugin/src/domain/entities/vietmap_reverse_params.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  String? apikey = dotenv.env['VIETMAP_API_KEY'];

  group('Test Vietmap v3 APIs', () {
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
  group('Test Vietmap v4 APIs', () {
    test('API key should not be null', () {
      expect(apikey, isNotEmpty);
      Vietmap.getInstance(apikey!);
    });

    test('Test autocomplete v4 function', () async {
      var res = await Vietmap.autocompleteV4(
          VietmapAutocompleteParamsV4(text: 'Vietmap'));
      res.fold(
          (l) => false,
          (r) =>
              expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>()));
    });

    test('Test geocode v4 function', () async {
      var res =
          await Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(text: 'Hà Nội'));
      res.fold(
          (l) => false,
          (r) =>
              expect(r, const TypeMatcher<List<VietmapAutocompleteModelV4>>()));
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
    test('Test reverse v4 function', () async {
      var res = await Vietmap.reverseV4(
          VietmapReverseParams(latLng: const LatLng(21.027763, 105.834160)));
      res.fold((l) => false, (r) => expect(r, isA<VietmapReverseModelV4>()));
    });
    test('Test place v4 function', () async {
      var res = await Vietmap.placeV4('Place ID');
      res.fold((l) => false, (r) => expect(r, isA<VietmapPlaceModel>()));
    });
    test('Test routing function', () async {
      var res = await Vietmap.routing(VietMapRoutingParams(points: [
        const LatLng(10.779391, 106.624833),
        const LatLng(10.741039, 106.672116)
      ]));
      res.fold((l) => false, (r) => expect(r, isA<VietMapRoutingModel>()));
    });
    test('Test getMapStyle function', () async {
      var res = Vietmap.getMapStyle(type: TileMapEnum.vectorLight);
      expect(res, isNotEmpty);
    });
    test('Test getVietmapBaseUrl function', () async {
      var res = Vietmap.getVietmapBaseUrl();
      expect(res, isNotEmpty);
    });

    test('Test address migratetion function', () async {
      var res = await Vietmap.migrateAddress(
          VietmapMigrateAddressParams(text: '10 Đường Láng, Đống Đa, Hà Nội'));
      res.fold(
          (l) => false, (r) => expect(r, isA<VietmapMigrateAddressModel>()));
    });
  });
}
