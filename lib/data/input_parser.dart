import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AllStructures {
  List<Structure> structures;
  void addStructure (Structure struct) {
    structures.add(struct);
  }
  AllStructures(this.structures);
}

class Structure {
  final int capacity;
  final String name;

  Structure(this.capacity, this.name);
}

Future<String> _loadDataAsset() async {
  return await rootBundle.loadString('assets/data/availability.json');
}

Future<AllStructures> loadData() async {
  String availability = await _loadDataAsset();
  AllStructures structures = _parseJsonForAvailability(availability);
  return structures;
}

AllStructures _parseJsonForAvailability(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  AllStructures structures;

  for (var i = 0; i < 10; ++i) {
    String capacity = "capacity" + i.toString();
    String name = "name" + i.toString();
    int cap = decoded[capacity];
    String structName = decoded[name];
    Structure structure = new Structure(cap, structName);
    structures.addStructure(structure);
  }
  return structures;

}