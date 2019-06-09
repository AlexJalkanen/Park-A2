import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapDisplay extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapDisplay> {
   PermissionStatus _status;
   static const double _zoom = 14.5;
   double lat = 42.281285;
   double long = -83.743932;
   static const LatLng _center = const LatLng(42.281285, -83.743932);
   CameraPosition _initialPosition = CameraPosition(target: _center, zoom: _zoom);
   MapType _defaultMapType = MapType.normal;
   Completer<GoogleMapController> _controller = Completer();

   @override
   void initState() {
     super.initState();
     PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse)
         .then(_updateStatus);
   }

   void _updateStatus(PermissionStatus status) async {
      if(status != _status) {
        setState(() {
          _status = status;
        });
      }
   }

   bool _askPermission() {
     PermissionHandler().requestPermissions(
       [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
     if(_status == PermissionStatus.granted) {
       return true;
     }
     else {
       return false;
     }
   }

   void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
     final status = statuses[PermissionGroup.locationWhenInUse];
     if(status != PermissionStatus.granted) {
       PermissionHandler().openAppSettings();
     } else {
       _updateStatus(status);
     }
   }

   void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: setMarkers(),
            onMapCreated: _onMapCreated,
            myLocationEnabled: _askPermission(),
            initialCameraPosition: _initialPosition,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => MapDisplay(),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.white,
                child: const Icon(Icons.refresh, size: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressed(String name, int capacity) {


      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Colors.blue[100],
          height: 350,
          width: 1000,
          child: Text.rich(
            TextSpan(
              //text: 'Hello', // default text style
              children: <TextSpan>[
                TextSpan(text: 'Name \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                TextSpan(text:  name , style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                TextSpan(text: 'Price \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                TextSpan(text: 'price_in', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                TextSpan(text: 'Available Spots \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                TextSpan(text: capacity.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
              ],
            ),
          ),

        );
      });

  }
  
  Set<Marker> setMarkers() {
     Set<Marker> _markers = Set();
   _markers.clear();
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwashington'),
   position: LatLng(42.2805163, -83.7481832),
   infoWindow: InfoWindow(title: 'Fourth and Washington Structure', snippet: 'Fourth and Washington Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('firstandwashington'),
   position: LatLng(42.2804774, -83.7500788),
   infoWindow: InfoWindow(title: 'First and Washington Structure', snippet: 'First and Washington Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('maynard'),
   position: LatLng(42.2789278, -83.7421086),
   infoWindow: InfoWindow(title: 'Maynard Structure', snippet: 'Maynard Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('forest'),
   position: LatLng(42.2743915, -83.733201),
   infoWindow: InfoWindow(title: 'Forest Structure', snippet: 'Forest Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwilliam'),
   position: LatLng(42.2784615, -83.7477646),
   infoWindow: InfoWindow(title: 'Fourth and William Structure', snippet: 'Fourth and William Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertysquare'),
   position: LatLng(42.280283, -83.7428007),
   infoWindow: InfoWindow(title: 'Liberty Square Structure', snippet: 'Liberty Square Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('annashley'),
   position: LatLng(42.2826333, -83.7496376),
   infoWindow: InfoWindow(title: 'Ann Ashley Structure', snippet: 'Ann Ashley Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertylane'),
   position: LatLng(42.2787552,-83.7455673),
   infoWindow: InfoWindow(title: 'Liberty Lane Structure', snippet: 'Liberty Lane Structure'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('southashley'),
   position: LatLng(42.2793726, -83.7498497),
   infoWindow: InfoWindow(title: 'South Ashley Lot', snippet: 'South Ashley Lot'),
       onTap: () => _onPressed("name", 5)
   ),
   );
   return _markers;
   }
}