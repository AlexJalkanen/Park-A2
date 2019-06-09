import 'dart:async';
import 'package:flutter/material.dart';
import 'data/input_parser.dart';
import 'home_widget.dart';
import 'package:a2hackathon/parser.dart' as parser;

void main(List<String> arguments) async {
  print(await parser.initiate());
  Future<AllStructures> structures = loadData();
  runApp(MaterialApp(
    title: 'Park A2',
    home: Home(),
    theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
  ));
}

