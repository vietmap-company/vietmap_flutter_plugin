import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

enum VehicleType { car, bike, foot, motorcycle }

/// Params for VietMapRouting api call
class VietMapRoutingParams {
  List<LatLng> points;
  VehicleType vehicle;
  bool optimize;

  VietMapRoutingParams(
      {required this.points,
      this.vehicle = VehicleType.car,
      this.optimize = false});
  toMap(String apiKey) {
    if (points.length < 2) {
      throw Exception('Points must be more than 2');
    }
    return {
      'api-version': '1.1',
      'apikey': apiKey,
      'vehicle': vehicle.name,
      'optimize': optimize
    };
  }
}
