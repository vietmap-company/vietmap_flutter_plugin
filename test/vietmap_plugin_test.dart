import 'package:flutter_test/flutter_test.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

void main() {
  test('adds one to input values', () {
    expect(Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: '')), []);
  });
}
