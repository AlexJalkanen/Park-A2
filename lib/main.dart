import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data/input_parser.dart';

void main() {
  runApp(MaterialApp(
    
    title: 'Park A2',
    home: Map(),
    theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
  ));
}

class Map extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<Map> {
   Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(42.281285, -83.743932);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => print('button pressed'),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 36.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
