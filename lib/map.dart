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
   String Price;

   GoogleMapController controller;
    Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
    int _polylineIdCounter = 1;
    PolylineId selectedPolyline;

    void _add(var x, var y, var x2, var y2) {
      final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
      _polylineIdCounter++;
      final PolylineId polylineId = PolylineId(polylineIdVal);
      final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.green,
      width: 15,
      points: _createPoints(x, y, x2, y2),
      );
      setState(() {
        polylines[polylineId] = polyline;
      });
    }

    List<LatLng> _createPoints(var x, var y, var x2, var y2) {
      final List<LatLng> points = <LatLng>[];
      points.add(_createLatLng(x, y));
      points.add(_createLatLng(x2, y2));
      return points;
  }
    LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
    }
   

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
     setMarkers();
     
     //_add(42.281285, -83.743932, 42.281285, -83.744932);
     _add(42.284915,-83.749554, 42.283309,-83.749665);
     _add(-83.749557, 42.284922, -83.749664, 42.283332);
     _add(42.284854,-83.747068, 42.283247,-83.747169);
     _add(42.284846,-83.747010, 42.284822,-83.745948);
     _add(42.284818,-83.745752, 42.284803,-83.745296);
     _add(42.284747,-83.745248, 42.284247,-83.745784);
     _add(42.284779,-83.745848, 42.284255,-83.745859);
     _add(42.284138,-83.745863, 42.283245,-83.745931);
     _add(42.283919,-83.746070, 42.283268,-83.746701);
     _add(42.284826,-83.747078, 42.283280,-83.747165);
     _add(42.283216,-83.750898, 42.282477,-83.750912);
     _add(42.282414,-83.750784, 42.282382,-83.749872);
     _add(42.282263,-83.749711, 42.281588,-83.749744);
     _add(42.283112,-83.747159, 42.282382,-83.747202);
     _add(42.283128,-83.748425, 42.282446,-83.748435);
     _add(42.282350,-83.748296, 42.282311,-83.747320);
     _add(42.282231,-83.747202, 42.281488,-83.747245);
     _add(42.282297,-83.747084, 42.282274,-83.746140);
     _add(42.283067,-83.745926, 42.282393,-83.745990);
     _add(42.282258,-83.745786, 42.282202,-83.743951);
     _add(42.280646,-83.753585, 42.280583,-83.751183);
     _add(42.281345,-83.750968, 42.280646,-83.750998);
     _add(42.280456,-83.751020, 42.279622,-83.751063);
     _add(42.280556,-83.750877, 42.280541,-83.749987);
     _add(42.279564,-83.750898, 42.279612,-83.750019);
     _add(42.281311,-83.749762, 42.280623,-83.749797);
     _add(42.280408,-83.749808, 42.279726,-83.749829);
     _add(42.280535,-83.749636, 42.280496,-83.748714);
     _add(42.279599,-83.749701, 42.279583,-83.748735);
     _add(42.281281,-83.748492, 42.280623,-83.748567);
     _add(42.280376,-83.748546, 42.279678,-83.748578);
     _add(42.280472,-83.748428, 42.280456,-83.747437);
     _add(42.279567,-83.748478, 42.279519,-83.747469);
     _add(42.281242,-83.747280, 42.280535,-83.747291);
     _add(42.280329,-83.747291, 42.279630,-83.747366);
     _add(42.280432,-83.747173, 42.280416,-83.746240);
     _add(42.279519,-83.747254, 42.279487,-83.746289);
     _add(42.281223,-83.746025, 42.280511,-83.746074);
     _add(42.280313,-83.746085, 42.279614,-83.746117);
     _add(42.280416,-83.745913, 42.280369,-83.744133);
     _add(42.279487,-83.746010, 42.279424,-83.744197);
     _add(42.280366,-83.743865, 42.280271,-83.74101);
     _add(42.279445,-83.743918, 42.279342,-83.740980);
     _add(42.281049,-83.740907, 42.280369,-83.740870);
     _add(42.280146,-83.740860, 42.279424,-83.740828);
     _add(42.280257,-83.740710, 42.280300,-83.739759);
     _add(42.280332,-83.739491, 42.280387,-83.737303);
     _add(42.280297,-83.737159, 42.278765,-83.737084);
     _add(42.280202,-83.739625, 42.278678,-83.739550);
     _add(42.278567,-83.740676, 42.278583,-83.739658);
     _add(42.279207,-83.740801, 42.277985,-83.740791);
     _add(42.277826,-83.740987, 42.277826,-83.741867);
     _add(42.279239,-83.742038, 42.277916,-83.742007);
     _add(42.277813,-83.742168, 42.277820,-83.743037);
     _add(42.279281,-83.743251, 42.277940,-83.743240);
     _add(42.279292,-83.744077, 42.274484,-83.744299);
     _add(42.277815,-83.744321, 42.277947,-83.748482);
     _add(42.277987,-83.747431, 42.278456,-83.747404);
     _add(42.279456,-83.748627, 42.278043,-83.748680);
     _add(42.279445,-83.748605, 42.276889,-83.748738);
     _add(42.279458,-83.749864, 42.276310,-83.750014);
     _add(42.276167,-83.749843, 42.276198,-83.748996);
     _add(42.277693,-83.741997, 42.276201,-83.741975);
     _add(42.276169,-83.744077, 42.276201,-83.741975);
     _add(42.277693,-83.743219, 42.274252,-83.743153);
     _add(42.274153,-83.743959, 42.274177,-83.743316);
     _add(42.274185,-83.742973, 42.274193,-83.740882);
     _add(42.274066,-83.740703, 42.265878,-83.740499);
     _add(42.273285,-83.742487, 42.273311,-83.738354);
     _add(42.273200,-83.739470, 42.271970,-83.739427);
     _add(42.271874,-83.740814, 42.271843,-83.741425);
     _add(42.271747,-83.741564, 42.271065,-83.740781);
     _add(42.270977,-83.740438, 42.271049,-83.739119);
     _add(42.277693,-83.740764, 42.275026,-83.740732);
     _add(42.274841,-83.738255, 42.272046,-83.738205);
     _add(42.274934,-83.738140, 42.275034,-83.731592);
     _add(42.276992,-83.734663, 42.272195,-83.734559);
     _add(42.274867,-83.735771, 42.272131,-83.735738);
     _add(42.272044,-83.735609, 42.272076,-83.734666);
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
            polylines: Set<Polyline>.of(polylines.values),
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

  void _onPressed(String name, String capacity, String price) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 270,
          child: Container(
          child: build_container(name, capacity, price),
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

  Column build_container (String name, String capacity, String price) {
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
                 TextSpan(text: Price, style: TextStyle(fontSize: 18)),
                 TextSpan(text: 'Available Spots: \n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 TextSpan(text: capacity, style: TextStyle(fontSize: 18)),
                 TextSpan(text: '\n'),
               ],
             ),
             ),
           ),
           ListTile (
             title: RichText(text: TextSpan(
               style: DefaultTextStyle.of(context).style,
               children: <TextSpan>[
                 TextSpan(text: 'Price: \n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 TextSpan(text: price, style: TextStyle(fontSize: 18)),
               ],
             ),
             ),
           ),
         ],
        );
      
  }

  void updateMarkers() async {
     await initiate();
     var time = new DateTime.now();
     if(time.weekday == DateTime.sunday){
         Price = "free\n";
     }
     else {
       Price = "\$1.20\n";
     }
  }
  
  void setMarkers() {
     _markers = Set();
   _markers.clear();
     //String str = parkMap[0];
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwashington'),
   position: LatLng(42.2805163, -83.7481832),

   infoWindow: null,
       onTap: () => _onPressed("Fourth & Washington Structure", Four_and_Wash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('firstandwashington'),
   position: LatLng(42.2804774, -83.7500788),
   infoWindow: null,
       onTap: () => _onPressed('First & Washington Structure', Fir_and_Wash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('maynard'),
   position: LatLng(42.2789278, -83.7421086),
   infoWindow: null,
       onTap: () => _onPressed('Maynard Structure', Maynard_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('forest'),
   position: LatLng(42.2743915, -83.733201),
   infoWindow: null,
       onTap: () => _onPressed('Forest Structure', Forest_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwilliam'),
   position: LatLng(42.2784615, -83.7477646),
   infoWindow: null,
       onTap: () => _onPressed('Fourth & William Structure', Four_and_Will_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertysquare'),
   position: LatLng(42.280283, -83.7428007),
   infoWindow: null,
       onTap: () => _onPressed('Liberty Square Structure', Lib_Square_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('annashley'),
   position: LatLng(42.2826333, -83.7496376),
   infoWindow: null,
       onTap: () => _onPressed('Ann Ashley Structure', Ann_Ash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertylane'),
   position: LatLng(42.2787552,-83.7455673),
   infoWindow: null,
       onTap: () => _onPressed('Library Lane Structure', Lib_Lane_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('southashley'),
   position: LatLng(42.2793726, -83.7498497),
   infoWindow: null,
       onTap: () => _onPressed('South Ashley Lot', South_Ash_Count, "\$1.70/hour")
   ),
   );
   }
}