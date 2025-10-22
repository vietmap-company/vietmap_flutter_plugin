/// Model class representing the response from Vietmap Matrix API
class VietmapMatrixModel {
  /// [code] A code indicating the status of the response.
  String? code;

  /// [messages] Messages associated with the response, if any.
  String? messages;

  /// [durations] A 2D list representing the travel durations. 
  /// Each value in the row represents the travel duration from the origin to a corresponding destination point in the list.
  List<List<num>>? durations;

  /// [distances] A 2D list representing the travel distances.
  /// Each value in the row represents the travel distance from the origin to a corresponding destination point in the list.
  List<List<num>>? distances;

  VietmapMatrixModel(
      {this.code, this.messages, this.durations, this.distances});

  VietmapMatrixModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    messages = json['messages'];
    if (json['durations'] != null) {
      durations = List<List<num>>.from(
          json['durations']?.map((e) => List<num>.from(e.map((e2) => e2))));
    }
    if (json['distances'] != null) {
      distances = List<List<num>>.from(
          json['distances']?.map((e) => List<num>.from(e.map((e2) => e2))));
    }
  }
}
