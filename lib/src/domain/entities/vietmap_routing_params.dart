import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

enum VehicleType { car, bike, foot, motorcycle }

class VietMapRoutingParams {
  String apiKey;

  List<LatLng> points;
  VehicleType vehicle;
  bool optimize;

  VietMapRoutingParams(
      {required this.apiKey,
      required this.points,
      this.vehicle = VehicleType.car,
      this.optimize = false});
  toMap() {
    return {
      'api-version': '1.1',
      'apikey': apiKey,
      'vehicle': vehicle.name,
      'optimize': optimize
    };
  }
}
