
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
```


## Additional information
This package is a part of [Vietmap API](https://vietmap.vn/maps-api) project.

