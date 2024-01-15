// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Vietmap flutter plugin demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VietmapController? _mapController;
  final List<Marker> _nearbyMarker = [];

  Future<void> _incrementCounter() async {
    var res = await Vietmap.reverse(const LatLng(21.027763, 105.834160));

    Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.geoCode(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.reverse(const LatLng(21.027763, 105.834160));
    Vietmap.place('Place ID');
    var routingResponse = await Vietmap.routing(VietMapRoutingParams(points: [
      const LatLng(10.779391, 106.624833),
      const LatLng(10.741039, 106.672116)
    ]));
    routingResponse.fold((Failure failure) {
      // handle failure here
    }, (VietMapRoutingModel success) {
      if (success.paths?.isNotEmpty == true &&
          success.paths![0].points?.isNotEmpty == true) {}
    });
    Vietmap.getVietmapStyleUrl();
  }

  @override
  void initState() {
    /// Must call this method before use Vietmap APIs.
    Vietmap.getInstance("YOUR_API_KEY_HERE");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    VietmapGL(
                        onMapCreated: (controller) {
                          setState(() {
                            _mapController = controller;
                          });
                        },
                        trackCameraPosition: true,
                        myLocationEnabled: true,
                        myLocationRenderMode: MyLocationRenderMode.COMPASS,
                        myLocationTrackingMode:
                            MyLocationTrackingMode.TrackingCompass,
                        initialCameraPosition: const CameraPosition(
                            target: LatLng(21.027763, 105.834160), zoom: 7),
                        styleString: Vietmap.getVietmapStyleUrl()),
                    _mapController == null
                        ? const SizedBox.shrink()
                        : MarkerLayer(
                            markers: _nearbyMarker,
                            mapController: _mapController!)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter a search term',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {},
                    )
                  ],
                )),
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                var res = await Vietmap.autocomplete(
                    VietMapAutoCompleteParams(textSearch: 'Hue'));
                res.fold((l) => {}, (r) {
                  print(r.first.toJson());
                });
              },
              child: Icon(Icons.list),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
                onPressed: () async {
                  var res = await Vietmap.reverse(
                      const LatLng(11.94512696144, 106.816722168));
                  res.fold((l) => {}, (r) {
                    print(r.toJson());
                  });
                },
                child: const Icon(Icons.location_on)),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
