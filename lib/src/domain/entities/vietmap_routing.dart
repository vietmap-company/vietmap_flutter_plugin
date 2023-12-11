import '../../data/models/vietmap_routing_model.dart';

/// VietmapRouting is a model which contains the information of a VietmapRouting response.
class VietMapRouting {
  /// [license] is the license of the response.
  String? license;

  /// [code] is the code of the response.
  String? code;

  /// [messages] is the messages of the response.
  String? messages;

  /// [paths] is the route to the destination, it will response 1 or more paths.
  List<PathModel>? paths;

  VietMapRouting({this.license, this.code, this.messages, this.paths});
}

//
class Paths {
  /// [distance] is the distance of the path.
  num? distance;

  num? weight;

  /// [time] is the estimated time of the path.
  int? time;

  int? transfers;

  bool? pointsEncoded;

  /// [bbox] is the bounding box of the path. It is a list of 4 numbers [minLon, minLat, maxLon, maxLat].
  /// You can use it to move camera to this bounding box by using [VietmapController.moveCamera],
  /// it will move camera to view all the path inside the screen.
  List<num?>? bbox;

  /// [points] is the encoded points of the path, which response a list of points in the path.
  /// You can decode it by using [VietmapPolylineDecoder.decodePolyline] method from [vietmap_gl_platform_interface] package.
  String? points;

  /// [instructions] is the instructions of the path, which response a list of instructions in the path.
  /// You can use it to display the instructions to the user.
  List<InstructionModel>? instructions;

  /// [snappedWaypoints] is the snapped waypoints of the path, which response a list of snapped waypoints in the path.
  String? snappedWaypoints;

  Paths(
      {this.distance,
      this.weight,
      this.time,
      this.transfers,
      this.pointsEncoded,
      this.bbox,
      this.points,
      this.instructions,
      this.snappedWaypoints});
}

class Instructions {
  /// [distance] is the distance of the instruction.
  num? distance;

  /// [heading] is the heading of the instruction.
  num? heading;

  /// [sign] is the sign of the instruction.
  num? sign;
  List<num?>? interval;

  /// [text] is the text of the instruction.
  String? text;

  /// [time] is the time of the instruction.
  num? time;

  /// [streetName] is the street name of the instruction.
  String? streetName;

  /// [lastHeading] is the last heading of the instruction.
  num? lastHeading;

  Instructions(
      {this.distance,
      this.heading,
      this.sign,
      this.interval,
      this.text,
      this.time,
      this.streetName,
      this.lastHeading});
}
