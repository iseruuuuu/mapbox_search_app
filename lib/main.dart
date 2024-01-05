import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_api/mapbox_api.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MapboxApi mapbox = MapboxApi(
      accessToken: ''
  );

  @override
  void initState() {
    getLocation();
  }

  Future<void> onTap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Container(),
      ),
    );
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      print(position.longitude);
      print(position.latitude);

      final response = await mapbox.forwardGeocoding.request(
        searchText: 'restaurant',
        fuzzyMatch: true,
        language: 'jp',
        proximity: <double>[
          position.latitude, // latitude
          position.longitude, // longitude
        ],
      );

      print(response.);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
