enum ReverseDisplayType {
  /// [newFormat] New merged administrative format (2 levels: ward, city).
  newFormat(value: 1),

  /// [oldFormat] Old administrative format (3 levels: ward, district, city). This is the default behavior.
  oldFormat(value: 2),

  /// [twoObjects] Returns both formats as two items in the list (a new-format item and an old-format item).
  twoObjects(value: 4),

  /// [bothNewAndOld] Returns new-format object at top level and provides old-format variant in data_old.
  bothNewAndOld(value: 5),

  /// [bothOldAndNew] Returns old-format object at top level and provides new-format variant in data_new.
  bothOldAndNew(value: 6);

  final int value;

  const ReverseDisplayType({required this.value});
}
