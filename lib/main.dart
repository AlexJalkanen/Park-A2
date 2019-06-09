import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:a2hackathon/parser.dart' as parser;

void main(List<String> arguments) async {
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
      appBar: null,
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14.0,
          ),
        ),
    );
  }
}
