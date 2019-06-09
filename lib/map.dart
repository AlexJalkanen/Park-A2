import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

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
   Set<Marker> _markers;
   String Four_and_Wash_Count;
   String Fir_and_Wash_Count;
   String Maynard_Count;
   String Forest_Count;
   String Four_and_Will_Count;
   String Lib_Square_Count;
   String Ann_Ash_Count;
   String Lib_Lane_Count;
   String South_Ash_Count;

   Future<void> initiate () async {
     var client = Client();
     Response response = await client.get(
         'https://payment.rpsa2.com/LocationAndRate/SpaceAvailability'
     );
     var document = parse(response.body);
     List<dom.Element> links = document.querySelectorAll('td');

     int count = 0;
     for (var link in links) {
       var string = link.text;
       var spaces = string.substring(
           (string.indexOf(" - ")) + 3, string.indexOf(" spaces"));
       var intBoi = int.parse(spaces);
       var structure = string.substring(42, string.indexOf(" - "));
       switch(count) {
         case 0:
           Four_and_Wash_Count = spaces;
           break;
         case 1:
           Fir_and_Wash_Count = spaces;
           break;
         case 2:
           Maynard_Count = spaces;
           break;
         case 3:
           Forest_Count = spaces;
           break;
         case 4:
           Four_and_Will_Count = spaces;
           break;
         case 5:
           Lib_Square_Count = spaces;
           break;
         case 6:
           Ann_Ash_Count = spaces;
           break;
         case 7:
           Lib_Lane_Count = spaces;
           break;
         case 8:
           South_Ash_Count = spaces;
           break;
       }
       count++;
     }
   }

   @override
   void initState() {
     super.initState();
     PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse)
         .then(_updateStatus);
     updateMarkers();
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
            markers: _markers,
            onMapCreated: _onMapCreated,
            myLocationEnabled: _askPermission(),
            initialCameraPosition: _initialPosition,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => updateMarkers(),
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

  void _onPressed(String name, String capacity) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 270,
          child: Container(
          child: build_container(name),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          ),
        );
      });

  }

  Column build_container (String name) {
     return Column(
         children: <Widget>[
         ListTile (
          title: RichText(text: TextSpan(
             style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: '\n'),
                TextSpan(text: name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                TextSpan(text: '\n'),
              ],
              ),
            ),
          ),
           ListTile (
             title: RichText(text: TextSpan(
               style: DefaultTextStyle.of(context).style,
               children: <TextSpan>[
                 TextSpan(text: 'Price \n', style: TextStyle(fontSize: 20)),
                 TextSpan(text: 'Price \n', style: TextStyle(fontSize: 18)),
               ],
             ),
             ),
           ),
           ListTile (
             title: RichText(text: TextSpan(
               style: DefaultTextStyle.of(context).style,
               children: <TextSpan>[
                 TextSpan(text: 'Available Spots \n', style: TextStyle(fontSize: 20)),
                 TextSpan(text: 'num spots in \n', style: TextStyle(fontSize: 18)),
               ],
             ),
             ),
           ),
         ],
        );
      
  }

  void updateMarkers() async {
     await initiate();
  }
  
  void setMarkers() {
     _markers = Set();
   _markers.clear();
     //String str = parkMap[0];
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwashington'),
   position: LatLng(42.2805163, -83.7481832),

   infoWindow: InfoWindow(title: 'Fourth and Washington Structure', snippet: 'Fourth and Washington Structure'),
       onTap: () => _onPressed("name", Four_and_Wash_Count)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('firstandwashington'),
   position: LatLng(42.2804774, -83.7500788),
   infoWindow: InfoWindow(title: 'First and Washington Structure', snippet: 'First and Washington Structure'),
       onTap: () => _onPressed('First & Washington Structure', "5" /*, parkMap[1]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('maynard'),
   position: LatLng(42.2789278, -83.7421086),
   infoWindow: InfoWindow(title: 'Maynard Structure', snippet: 'Maynard Structure'),
       onTap: () => _onPressed('Maynard Structure', "5"/*, parkMap[2]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('forest'),
   position: LatLng(42.2743915, -83.733201),
   infoWindow: InfoWindow(title: 'Forest Structure', snippet: 'Forest Structure'),
       onTap: () => _onPressed('Forest Structure', "5"/*, parkMap[3]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwilliam'),
   position: LatLng(42.2784615, -83.7477646),
   infoWindow: InfoWindow(title: 'Fourth and William Structure', snippet: 'Fourth and William Structure'),
       onTap: () => _onPressed('Fourth & William Structure', "5"/*, parkMap[4]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertysquare'),
   position: LatLng(42.280283, -83.7428007),
   infoWindow: InfoWindow(title: 'Liberty Square Structure', snippet: 'Liberty Square Structure'),
       onTap: () => _onPressed('Liberty Square Structure', "5"/*, parkMap[5]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('annashley'),
   position: LatLng(42.2826333, -83.7496376),
   infoWindow: InfoWindow(title: 'Ann Ashley Structure', snippet: 'Ann Ashley Structure'),
       onTap: () => _onPressed('Ann Ashley Structure', "5" /*, parkMap[6]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertylane'),
   position: LatLng(42.2787552,-83.7455673),
   infoWindow: InfoWindow(title: 'Liberty Lane Structure', snippet: 'Liberty Lane Structure'),
       onTap: () => _onPressed('Library Lane Structure', "5"/*, parkMap[7]*/)
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('southashley'),
   position: LatLng(42.2793726, -83.7498497),
   infoWindow: InfoWindow(title: 'South Ashley Lot', snippet: 'South Ashley Lot'),
       onTap: () => _onPressed('South Ashley Lot', "5" /*, parkMap[8]*/)
   ),
   );
   }
}