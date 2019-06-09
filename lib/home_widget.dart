import 'package:flutter/material.dart';
import 'map.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Map(), null];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), 
        child: AppBar(
          title: Text('Park A2'),
          backgroundColor: Colors.white,
          centerTitle: true
        )
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.map),
           title: new Text('Map'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           title: Text('Settings')
         )
       ],
     ),
   );
 }
 void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}