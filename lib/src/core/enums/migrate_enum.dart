enum MigrateEnum {
  /// 1: migrate from old to new format
  oldToNew(value: 1),

  /// 2: migrate from new to old format. If migrate_type = 2, focus param must be provided
  newToOld(value: 2);

  final int value;

  const MigrateEnum({required this.value});
}
