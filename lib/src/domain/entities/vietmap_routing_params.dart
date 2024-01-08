import '../../../vietmap_flutter_plugin.dart';

enum VehicleType { car, bike, foot, motorcycle }

/// Params for VietMapRouting api call
class VietMapRoutingParams {
  /// [points] : [List<LatLng>] list of points that you want to routing, allow 2 points at least
  List<LatLng> points;

  /// [vehicle] : [VehicleType] type of vehicle that you want to routing, default is car
  VehicleType vehicle;

  /// [optimize] : [bool] optimize the route, default is false
  bool optimize;

  VietMapRoutingParams(
      {required this.points,
      this.vehicle = VehicleType.car,
      this.optimize = false});
  toMap() {
    if (points.length < 2) {
      throw Exception('Points must be more than 2');
    }
    return {
      'api-version': '1.1',
      'apikey': Vietmap.getVietmapAPIKey(),
      'vehicle': vehicle.name,
      'optimize': optimize
    };
  }
}
