enum AutocompleteDisplayType {
  /// [newFormat] New merged administrative format (2 levels: ward, city).
  newFormat(value: 1),

  /// [oldFormat] Old administrative format (3 levels: ward, district, city).
  oldFormat(value: 2),

  /// [asInputFormat] API will detect user input and response model like input format.
  asInputFormat(value: 3),

  /// [bothNewAndOld] Returns new-format object and indicates old (legacy) boundaries.
  bothNewAndOld(value: 5),

  /// [bothOldAndNew] Returns old-format object and indicates updated (new) boundaries.
  bothOldAndNew(value: 6);

  final int value;

  const AutocompleteDisplayType({required this.value});
}
