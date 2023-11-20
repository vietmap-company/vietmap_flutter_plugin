extension StringExtension on String {
  /// Capitalize first character of [String]
  /// Example: 'hello' -> 'Hello'
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Convert [json] to [String] with format: 'key1=value1&key2=value2'
  String convertJsonToUrlPath() {
    String path = this;
    path = path.replaceAll('{', '');
    path = path.replaceAll('}', '');
    path = path.replaceAll(',', '&');
    path = path.replaceAll(':', '=');
    path = path.replaceAll(' ', '');
    return path;
  }
}
