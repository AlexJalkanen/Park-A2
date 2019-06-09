import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class Garage {
  Garage(String name, String num_spots, String price) {
    this.name = name;
    this.num_spots = num_spots;
    this.price = price;
  }
  String name;
  String num_spots;
  String price;

}





class _MapPage extends State<Map> {
   Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(42.281285, -83.743932);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  bool condition = true;

  Garage g;




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


          /*if (condition)
            Align (
              alignment: Alignment.bottomCenter,
              child:
              new Container(
                color: Colors.blue[100],
                height: 350,
                width: 1000,
                child: Text.rich(
                  TextSpan(
                  //text: 'Hello', // default text style
                  children: <TextSpan>[
                    TextSpan(text: 'Name \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    TextSpan(text:  'name_in' , style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                    TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                    TextSpan(text: 'Price \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    TextSpan(text: 'price_in', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                    TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                    TextSpan(text: 'Available Spots \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    TextSpan(text: 'spots_in', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                  ],
                ),
                ),

              ),
            ),*/
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


   void on_button_pressed() {
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
               TextSpan(text:  'name_in' , style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
               TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
               TextSpan(text: 'Price \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
               TextSpan(text: 'price_in', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
               TextSpan(text:  '\n \n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
               TextSpan(text: 'Available Spots \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
               TextSpan(text: 'spots_in', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
             ],
           ),
         ),

       );
     });
   }
}
