library util;

import 'dart:math' as math;

import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart';

const earthRadius = 6371e3; //meter

class VietmapUtils {
  /// calculate square of sin : sin²
  /// [x] : (num) number that you want to calculate it's sin²
  static double sqrtSin(num x) {
    return math.sin(x) * math.sin(x);
  }

  /// calculate square of cos : cos²
  /// [x] : (num) number that you want to calculate it's cos²
  static double sqrtCos(num x) {
    return math.cos(x) * math.cos(x);
  }

  /// calculate multiplication of cos : cos x * cos y
  /// [x] : (num) number of the first cos
  /// [x] : (num) number of second cos
  static double sqrtCos2(num x, num y) {
    return math.cos(x) * math.cos(y);
  }

  /// calculate distance between 2 points on the earth surface
  /// using Haversine formula with the earth radius is 6371e3
  /// [p1] : (LatLng) first point
  /// [p2] : (LatLng) second point
  /// return : (Future<double>) distance between 2 points
  /// unit : meter
  static Future<double> distance2point(LatLng p1, LatLng p2) async {
    final phi1 = p1.latitude * math.pi / 180; // φ, λ in radians
    final phi2 = p2.latitude * math.pi / 180;
    final deltaPhi = (p2.latitude - p1.latitude) * math.pi / 180;
    final deltaLambda = (p2.longitude - p1.longitude) * math.pi / 180;

    final double a =
        sqrtSin(deltaPhi / 2) + sqrtCos2(phi1, phi2) * sqrtSin(deltaLambda / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c; //metres
  }
}
