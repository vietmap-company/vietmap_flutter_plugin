class VietmapMatrixModel {
  String? code;
  String? messages;
  List<List<num>>? durations;
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
