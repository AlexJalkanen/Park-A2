import 'dart:async';
import 'package:flutter/material.dart';
import 'data/input_parser.dart';
import 'home_widget.dart';
import 'package:a2hackathon/parser.dart' as parser;
import 'package:permission_handler/permission_handler.dart';

void main(List<String> arguments) async {
  runApp(MaterialApp(
    title: 'Park A2',
    home: Home(),
    theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
  ));
}
