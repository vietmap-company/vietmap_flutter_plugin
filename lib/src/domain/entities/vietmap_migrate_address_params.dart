import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

/// This class represents the parameters for migrating addresses between old and new formats.
class VietmapMigrateAddressParams {
  /// Specify the center of the search context expressed as coordinates. Required if migrate_type = 2
  final LatLng? focus;

  /// Address input (old or new format)
  final String text;

  /// Migrate type. See enum [MigrateType] for more details
  final int? migrateType;


  VietmapMigrateAddressParams({
    required this.text,
    this.focus,
    this.migrateType,
  });

  Map<String, dynamic> toQueryParam() {
    final Map<String, String> queryParams = {};
    queryParams['text'] = text;
    if (focus != null) {
      queryParams['focus'] = focus!.toUrlValue();
    }
    if (migrateType != null) {
      queryParams['migrate_type'] = migrateType.toString();
    }
    return queryParams;
  }
}