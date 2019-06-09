import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'home_widget.dart';

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
   String Four_and_Wash_Count = "100";
   String Fir_and_Wash_Count = "100";
   String Maynard_Count = "100";
   String Forest_Count = "100";
   String Four_and_Will_Count = "100";
   String Lib_Square_Count = "100";
   String Ann_Ash_Count = "100";
   String Lib_Lane_Count = "100";
   String South_Ash_Count = "100";
   String Price = "100";

   GoogleMapController controller;
    Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
    int _polylineIdCounter = 1;
    PolylineId selectedPolyline;

    void _add(var x, var y, var x2, var y2, String color) {
      final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
      _polylineIdCounter++;
      final PolylineId polylineId = PolylineId(polylineIdVal);
      if (color == "red") {
         final Polyline polyline = Polyline(
        polylineId: polylineId,
        consumeTapEvents: true,
        color: Colors.red,
        width: 15,
        points: _createPoints(x, y, x2, y2),
        );
        setState(() {
          polylines[polylineId] = polyline;
        });
      }
      else if (color == "yellow") {
         final Polyline polyline = Polyline(
        polylineId: polylineId,
        consumeTapEvents: true,
        color: Colors.yellow,
        width: 15,
        points: _createPoints(x, y, x2, y2),
        );
        setState(() {
          polylines[polylineId] = polyline;
        });
      }
      if (color == "green") {
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
           setState(() {
              Four_and_Wash_Count = spaces;
           });
           break;
         case 1:
         setState(() {
              Fir_and_Wash_Count = spaces;
           });
           
           break;
         case 2:
         setState(() {
              Maynard_Count = spaces;
           });
           
           break;
         case 3:
         setState(() {
             Forest_Count = spaces;
           });
           
           break;
         case 4:
         setState(() {
              Four_and_Will_Count = spaces;
           });
           
           break;
         case 5:
         setState(() {
              Lib_Square_Count = spaces;
           });
           
           break;
         case 6:
         setState(() {
              Ann_Ash_Count = spaces;
           });
           
           break;
         case 7:
         setState(() {
              Lib_Lane_Count = spaces;
           });
           
           break;
         case 8:
         setState(() {
              South_Ash_Count = spaces;
           });
           
           break;
       }
       count++;
     }
     removeMarkers();
     setMarkers();
   }

   @override
   void initState() {
     super.initState();
     PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse)
         .then(_updateStatus);
     updateMarkers();
     setMarkers();
     addStreets();
     
   }
  void _remove() {
    setState(() {
      polylines.clear();
      selectedPolyline = null;
    });
  }
   void addStreets(){
     _add(42.284915,-83.749554, 42.283309,-83.749665, "yellow");
     _add(-83.749557, 42.284922, -83.749664, 42.283332, "green");
     _add(42.284854,-83.747068, 42.283247,-83.747169, "green");
     _add(42.284846,-83.747010, 42.284822,-83.745948, "green");
     _add(42.284818,-83.745752, 42.284803,-83.745296, "green");
     _add(42.284747,-83.745248, 42.284247,-83.745784, "red");
     _add(42.284779,-83.745848, 42.284255,-83.745859, "green");
     _add(42.284138,-83.745863, 42.283245,-83.745931, "green");
     _add(42.283919,-83.746070, 42.283268,-83.746701, "green");
     _add(42.284826,-83.747078, 42.283280,-83.747165, "green");
     _add(42.283216,-83.750898, 42.282477,-83.750912, "yellow");
     _add(42.282414,-83.750784, 42.282382,-83.749872, "green");
     _add(42.282263,-83.749711, 42.281588,-83.749744, "green");
     _add(42.283112,-83.747159, 42.282382,-83.747202, "green");
     _add(42.283128,-83.748425, 42.282446,-83.748435, "green");
     _add(42.282350,-83.748296, 42.282311,-83.747320, "green");
     _add(42.282231,-83.747202, 42.281488,-83.747245, "green");
     _add(42.282297,-83.747084, 42.282274,-83.746140, "green");
     _add(42.283067,-83.745926, 42.282393,-83.745990, "green");
     _add(42.282258,-83.745786, 42.282202,-83.743951, "red");
     _add(42.280646,-83.753585, 42.280583,-83.751183, "green");
     _add(42.281345,-83.750968, 42.280646,-83.750998, "yellow");
     _add(42.280456,-83.751020, 42.279622,-83.751063, "green");
     _add(42.280556,-83.750877, 42.280541,-83.749987, "green");
     _add(42.279564,-83.750898, 42.279612,-83.750019, "green");
     _add(42.281311,-83.749762, 42.280623,-83.749797, "green");
     _add(42.280408,-83.749808, 42.279726,-83.749829, "green");
     _add(42.280535,-83.749636, 42.280496,-83.748714, "red");
     _add(42.279599,-83.749701, 42.279583,-83.748735, "green");
     _add(42.281281,-83.748492, 42.280623,-83.748567, "green");
     _add(42.280376,-83.748546, 42.279678,-83.748578, "green");
     _add(42.280472,-83.748428, 42.280456,-83.747437, "green");
     _add(42.279567,-83.748478, 42.279519,-83.747469, "yellow");
     _add(42.281242,-83.747280, 42.280535,-83.747291, "green");
     _add(42.280329,-83.747291, 42.279630,-83.747366, "green");
     _add(42.280432,-83.747173, 42.280416,-83.746240, "green");
     _add(42.279519,-83.747254, 42.279487,-83.746289, "green");
     _add(42.281223,-83.746025, 42.280511,-83.746074, "green");
     _add(42.280313,-83.746085, 42.279614,-83.746117, "green");
     _add(42.280416,-83.745913, 42.280369,-83.744133, "green");
     _add(42.279487,-83.746010, 42.279424,-83.744197, "green");
     _add(42.280366,-83.743865, 42.280271,-83.74101,  "green");
     _add(42.279445,-83.743918, 42.279342,-83.740980, "red");
     _add(42.281049,-83.740907, 42.280369,-83.740870, "yellow");
     _add(42.280146,-83.740860, 42.279424,-83.740828, "green");
     _add(42.280257,-83.740710, 42.280300,-83.739759, "green");
     _add(42.280332,-83.739491, 42.280387,-83.737303, "green");
     _add(42.280297,-83.737159, 42.278765,-83.737084, "green");
     _add(42.280202,-83.739625, 42.278678,-83.739550, "green");
     _add(42.278567,-83.740676, 42.278583,-83.739658, "red");
     _add(42.279207,-83.740801, 42.277985,-83.740791, "green");
     _add(42.277826,-83.740987, 42.277826,-83.741867, "green");
     _add(42.279239,-83.742038, 42.277916,-83.742007, "green");
     _add(42.277813,-83.742168, 42.277820,-83.743037, "yellow");
     _add(42.279281,-83.743251, 42.277940,-83.743240, "green");
     _add(42.279292,-83.744077, 42.274484,-83.744299, "green");
     _add(42.277815,-83.744321, 42.277947,-83.748482, "green");
     _add(42.277987,-83.747431, 42.278456,-83.747404, "green");
     _add(42.279456,-83.748627, 42.278043,-83.748680, "green");
     _add(42.279445,-83.748605, 42.276889,-83.748738, "green");
     _add(42.279458,-83.749864, 42.276310,-83.750014, "green");
     _add(42.276167,-83.749843, 42.276198,-83.748996, "green");
     _add(42.277693,-83.741997, 42.276201,-83.741975, "green");
     _add(42.276169,-83.744077, 42.276201,-83.741975, "green");
     _add(42.277693,-83.743219, 42.274252,-83.743153, "yellow");
     _add(42.274153,-83.743959, 42.274177,-83.743316, "red");
     _add(42.274185,-83.742973, 42.274193,-83.740882, "green");
     _add(42.274066,-83.740703, 42.265878,-83.740499, "green");
     _add(42.273285,-83.742487, 42.273311,-83.738354, "green");
     _add(42.273200,-83.739470, 42.271970,-83.739427, "green");
     _add(42.271874,-83.740814, 42.271843,-83.741425, "red");
     _add(42.271747,-83.741564, 42.271065,-83.740781, "green");
     _add(42.270977,-83.740438, 42.271049,-83.739119, "green");
     _add(42.277693,-83.740764, 42.275026,-83.740732, "yellow");
     _add(42.274841,-83.738255, 42.272046,-83.738205, "red");
     _add(42.274934,-83.738140, 42.275034,-83.731592, "green");
     _add(42.276992,-83.734663, 42.272195,-83.734559, "green");
     _add(42.274867,-83.735771, 42.272131,-83.735738, "green");
     _add(42.272044,-83.735609, 42.272076,-83.734666, "green");
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

  bool _value1 = true;
   bool _value2 = true;
   

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
          Visibility(
            visible: visible,
            child: Container (
            color: Colors.transparent,
            height: 125,
            width: 170,
            child: new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      bottomRight: const Radius.circular(10.0))),
            
            child: Align (
              alignment: Alignment.topLeft,
                child:
                new Column (
                  children: <Widget>[
                    new CheckboxListTile(
                      value: _value1,
                      onChanged: (bool value) {
                        setState(() => _value1 = value);
                        value == true ? setMarkers() : removeMarkers();
                      },
                      title: new Text('Parking Structures'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.red,
                    ),
                    new CheckboxListTile(
                      value: _value2,
                      onChanged: (bool value) {
                        setState(() => _value2 = value);
                        value == true ?  addStreets() : _remove();
                      },
                      title: new Text('Street Parking'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
          )
            
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
  }

  void removeMarkers() {
    setState(() {
      _markers.clear();
    });
  }

  BitmapDescriptor setColor(int capacity) {
    if (capacity < 0) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    }
    if (capacity < 50) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
    if (capacity < 400) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  }
  
  void setMarkers() {
     _markers = Set();
   _markers.clear();
     //String str = parkMap[0];
     setState(() {
       
    
       
     
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwashington'),
   position: LatLng(42.2805163, -83.7481832),
    icon: setColor(int.parse(Four_and_Wash_Count)),
   infoWindow: null,
       onTap: () => _onPressed("Fourth & Washington Structure", Four_and_Wash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('firstandwashington'),
   icon: setColor(int.parse(Fir_and_Wash_Count)),
   position: LatLng(42.2804774, -83.7500788),
   infoWindow: null,
       onTap: () => _onPressed('First & Washington Structure', Fir_and_Wash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('maynard'),
   icon: setColor(int.parse(Maynard_Count)),
   position: LatLng(42.2789278, -83.7421086),
   infoWindow: null,
       onTap: () => _onPressed('Maynard Structure', Maynard_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('forest'),
   position: LatLng(42.2743915, -83.733201),
   icon: setColor(int.parse(Forest_Count)),
   infoWindow: null,
       onTap: () => _onPressed('Forest Structure', Forest_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('fourthandwilliam'),
   position: LatLng(42.2784615, -83.7477646),
   icon: setColor(int.parse(Four_and_Will_Count)),
   infoWindow: null,
       onTap: () => _onPressed('Fourth & William Structure', Four_and_Will_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertysquare'),
   position: LatLng(42.280283, -83.7428007),
   icon: setColor(int.parse(Lib_Square_Count)),
   infoWindow: null,
       onTap: () => _onPressed('Liberty Square Structure', Lib_Square_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('annashley'),
   position: LatLng(42.2826333, -83.7496376),
   icon: setColor(int.parse(Ann_Ash_Count)),
   infoWindow: null,
       onTap: () => _onPressed('Ann Ashley Structure', Ann_Ash_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('libertylane'),
   position: LatLng(42.2787552,-83.7455673),
   icon: setColor(int.parse(Lib_Lane_Count)),
   infoWindow: null,
       onTap: () => _onPressed('Library Lane Structure', Lib_Lane_Count, "\$1.20/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('southashley'),
   position: LatLng(42.2793726, -83.7498497),
   icon: setColor(int.parse(South_Ash_Count)),
   infoWindow: null,
       onTap: () => _onPressed('South Ashley Lot', South_Ash_Count, "\$1.70/hour")
   ),
   );
   _markers.add(
   Marker(
   markerId: MarkerId('firstandwilliam'),
   position: LatLng(42.279587, -83.751292),
   icon: setColor(-1),
   infoWindow: null,
      onTap: () => _onPressed('First and William Lot', 'No Data', "\$1.60/hour for 1-3 hours \n"
       "\$1.80/hour for 4+ hours")
   ),
   );
    _markers.add(
    Marker(
    markerId: MarkerId('palio'),
    position: LatLng(42.278120, -83.748300),
    icon: setColor(-1),
    infoWindow: null,
       onTap: () => _onPressed('Palio Lot', 'No Data', "\$1.80/hour")
    ),
    );
     _markers.add(
       Marker(
           markerId: MarkerId('415washington'),
           position: LatLng(42.280266, -83.752322),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('415 W. Washington Lot', 'No Data', "\$4 flat rate")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('annandmain'),
           position: LatLng(42.282183, -83.748727),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Ann & Main St Lot', 'No Data', "\$1.80/hour")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('fourthandcatherine'),
           position: LatLng(42.283579, -83.747332),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Fourth and Catherine Lot', 'No Data', "\$1.80/hour")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('farmer'),
           position: LatLng(42.283579, -83.747332),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Farmer\'s Market Lot', 'No Data', "\$1.80/hour")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('community'),
           position: LatLng(42.283727, -83.745398),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Community High Lot', 'No Data', "\$1.80/hour")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('kerrytown'),
           position: LatLng(42.284477, -83.746819),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Kerrytown Lot', 'No Data', "\$1.80/hour")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('greenrd'),
           position: LatLng(42.299948, -83.693689),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Green Road Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('millerrd'),
           position: LatLng(42.298336, -83.788568),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Miller Road Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('pioneer'),
           position: LatLng(42.262449, -83.751942),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Pioneer High School Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('plymouth'),
           position: LatLng(42.305102, -83.688573),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Plymouth Road Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('statestreetcommuter'),
           position: LatLng(42.248734, -83.740780),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('State Street: Commuter Lot Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('statestreettennis'),
           position: LatLng(42.252746, -83.743286),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('State Street: U-M Tennis Center Lot Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('ypsi'),
           position: LatLng(42.242735, -83.615455),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Ypsilanti Transit Center Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('meijer'),
           position: LatLng(42.233294, -83.678516),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Meijer Park & Ride', 'No Data', "Free")
       ),
     );
     _markers.add(
       Marker(
           markerId: MarkerId('washtenaw'),
           position: LatLng(42.255126, -83.677953),
           icon: setColor(-1),
           infoWindow: null,
           onTap: () => _onPressed('Washtenaw County Service Center Park & Ride', 'No Data', "Free")
       ),
     );
      });
  }

}