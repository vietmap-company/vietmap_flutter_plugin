import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class VietmapMatrixParams {
  // /// VietMap apiKey
  // final String apikey;

  /// List of latLng point, include both of `sourcePoints` and `destinationPoints`.
  final List<LatLng> points;

  /// VietMap matrix api version
  final String apiVersion;

  /// List index of the source point inside list points
  final List<int> sourcePoints;

  /// List index of the source point inside the list points
  final List<int> destinationPoints;
  final bool isShowTablePreview;
  VietmapMatrixParams(
      {required this.points,
      this.isShowTablePreview = false,
      this.apiVersion = '1.1',
      required this.sourcePoints,
      required this.destinationPoints});
}
