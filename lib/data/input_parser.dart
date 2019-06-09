import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:a2hackathon/parser.dart' as parser;

class AllStructures {
  List<Structure> structures;
  void addStructure (Structure struct) {
    structures.add(struct);
  }
  AllStructures(this.structures);
}

Future<void> printStructures(AllStructures structure) {
    for (var struct in structure.structures) {
      print("Name: ");
      print(struct.name);
      print(" Capacity: ");
      print(struct.capacity);
    }
  }

class Structure {
  final int capacity;
  final String name;

  Structure(this.capacity, this.name);
}

Future<String> _loadDataAsset() async {
  return await parser.initiate();
}

Future<void> loadData() async {
  String availability = await _loadDataAsset();
  var data = await parser.initiate();
  print("*");
  print("*");
  print("*");
  print("*");
  print("*");
  for (var pair in data) {
    print(pair);
    print(pair["structure"]);
    print(pair["spaces"]);
  }
  //AllStructures structures = _parseJsonForAvailability(availability);
  //printStructures(structures);
  return;
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