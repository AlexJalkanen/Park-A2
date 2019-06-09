import 'package:flutter/material.dart';
import 'package:frideos_core/frideos_core.dart';
import 'map.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new    SingletonBloc._internal();
  final visible = StreamedValue<bool>();
  factory SingletonBloc() {
    return _singletonBloc;
  }
  SingletonBloc._internal() {
    visible.value = true;
  }
  dispose() {
    visible.dispose();
  }
}
final bloc = SingletonBloc();

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [MapDisplay(), null];

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
           icon: Icon(Icons.local_parking),
           title: Text('Options')
         )
       ],
     ),
     
   );
 }
 void onTabTapped(int index) {
   if (index == 1) {
     setState(() {
      bloc.visible.value = !bloc.visible.value;
    });
   }   
 }
}