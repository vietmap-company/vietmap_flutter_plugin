
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
- We provide below methods to use Vietmap APIs:
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
 