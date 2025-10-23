
A Dart package for using the [VietMap APIs](https://maps.vietmap.vn/docs/map-api/overview/) in Dart.

# Vietmap API Flutter plugin

[<img src="https://bizweb.dktcdn.net/100/415/690/themes/804206/assets/logo.png?1689561872933" height="40"/> </p>](https://vietmap.vn/maps-api)

Contact [vietmap.vn](https://bit.ly/vietmap-api) to register a valid key.

## Getting started

Add library to pubspec.yaml file
```yaml
  vietmap_flutter_plugin: latest_version
```

Check the latest version at [https://pub.dev/packages/vietmap_flutter_plugin](https://pub.dev/packages/vietmap_flutter_plugin)
 
or run this command in the terminal to add the library to the project:
```bash
  flutter pub add vietmap_flutter_plugin
```

## Usage

### Init plugin
- You must call `Vietmap.getInstance(apiKey)` before using any other methods.
```dart
    Vietmap.getInstance('YOUR_API_KEY_HERE');
```
- We provide the following methods for using VietMap APIs v3, but we recommend using VietMap APIs v4 instead:
```dart
    Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    
    Vietmap.geoCode(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    
    Vietmap.reverse(LatLng(21.027763, 105.834160));
    
    Vietmap.place('Place ID');
    
    Vietmap.routing(VietMapRoutingParams(points: [
      LatLng(21.027763, 105.834160),
      LatLng(21.027763, 105.834160)
    ]));
    
    /// This function is used to get the style url of Vietmap,
    /// which provide the style of the map for VietmapGL plugin.
    Vietmap.getVietmapStyleUrl();
    Vietmap.matrix(VietmapMatrixParams(
      points: [
        const LatLng(10.768897, 106.678505),
        const LatLng(10.765496, 106.67626),
        const LatLng(10.7627936, 106.6750729),
        const LatLng(10.7616745, 106.6792425),
        const LatLng(10.765605, 106.685383),
      ],
      sourcePoints: [0, 1],
      isShowTablePreview: true,
      destinationPoints: [
        2, 3, 4,
    ]));
                
```
- From version 0.5.0, we provide methods to use Vietmap APIs v4 with enhanced features:
```dart
    
    Vietmap.autocompleteV4(VietmapAutocompleteParamsV4(text: 'Hà Nội'));
    
    Vietmap.geoCodeV4(VietmapAutocompleteParamsV4(text: 'Hà Nội'));
    
    Vietmap.reverseV4(VietmapReverseParams(latLng: LatLng(21.027763, 105.834160)));
    
    /// refId: A unique refid identifier generated from search response
    Vietmap.placeV4('refId');
    
    Vietmap.migrateAddress(
      VietmapMigrateAddressParams(text: '197 Trần Phú, Phường 4, Quận 5, Thành phố Hồ Chí Minh, Việt Nam')
    );
    
    Vietmap.getMapStyle(type: TileMapEnum.vectorDefault); // Other options: vectorLight, rasterDefault, etc.

```

### Why use v4 APIs?
- [Autocomplete v4](https://maps.vietmap.vn/docs/map-api/autocomplete-version/autocomplete-v4): Enhanced address suggestions with better accuracy, more relevant results, and advanced filtering options including categories and boundaries

- [Geocode v4](https://maps.vietmap.vn/docs/map-api/geocode-version/geocode-v4): Improved address resolution with more detailed address components, better handling of Vietnamese addresses, and enhanced entry point data

- [Reverse v4](https://maps.vietmap.vn/docs/map-api/place-v4): Richer location context with more detailed address information, better handling of complex areas, and improved category classification

- [Place v4](https://maps.vietmap.vn/docs/map-api/place-v4): More comprehensive place details including enhanced POI information, accurate entry points, and improved address context

- [Migrate Address API](https://maps.vietmap.vn/docs/migrate-address/migrate-address-docs): New functionality to standardize addresses across different formats and provide consistent addressing for your applications

#### v4 APIs provide better performance, more accurate results, and richer data to improve your user experience.

## Additional information
This package is a part of [Vietmap API](https://vietmap.vn/maps-api) project.

## Troubleshooting
Our plugin depend on [dio](https://pub.dev/packages/dio) and [dartz](https://pub.dev/packages/dartz) package with latest version.
If our plugin conflict with your current project, please try to use the latest version of these packages or follow the instruction below:
```yaml
dependencies:
    dio: your_project_version
    dartz: your_project_version

dependencies_override:
    dio: our_plugin_version
    dartz: our_plugin_version
```

We use [dartz](https://pub.dev/packages/dartz) package to response the api result.
Please check the [dartz](https://pub.dev/packages/dartz) package to know how to handle the result.
```dart
var autocompleteData = await Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
autocompleteData.fold(
      (Failure left) {
        // Handle error here
      },
      (List<VietmapAutocompleteModel> right) {
        // Handle success here
      },
    );
```


## Note: Replace apikey which is provided by VietMap to all YOUR_API_KEY_HERE tag to the application work normally



[<img src="https://bizweb.dktcdn.net/100/415/690/themes/804206/assets/logo.png?1689561872933" height="40"/> </p>](https://vietmap.vn/maps-api)
Email us: [maps-api.support@vietmap.vn](mailto:maps-api.support@vietmap.vn)

Vietmap API and price [here](https://vietmap.vn/maps-api)

Contact for [support](https://vietmap.vn/lien-he)

Vietmap API document [here](https://maps.vietmap.vn/docs/map-api/overview/)

Have a bug to report? [Open an issue](https://github.com/vietmap-company/vietmap_flutter_plugin/issues). If possible, include a full log and information which shows the issue.


Have a feature request? [Open an issue](https://github.com/vietmap-company/vietmap_flutter_plugin/issues). Tell us what the feature should do and why you want the feature.
 