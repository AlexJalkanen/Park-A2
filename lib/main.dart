import 'dart:async';
import 'package:flutter/material.dart';
import 'data/input_parser.dart';
import 'home_widget.dart';

void main() {
  Future<AllStructures> structures = loadData();
  runApp(MaterialApp(
    title: 'Park A2',
    home: Home(),
    theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
  ));
}