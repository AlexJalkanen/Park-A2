import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future initiate () async {
  var client = Client();
  Response response = await client.get(
    'https://payment.rpsa2.com/LocationAndRate/SpaceAvailability'
  );
  var document = parse(response.body);
  List<Element> links = document.querySelectorAll('td');

  List<Map<String, dynamic>> parkMap = [];

  for (var link in links) {
    var numby = 1;
    var string = link.text;
    var spaces = string.substring(
        (string.indexOf(" - ")) + 3, string.indexOf(" spaces"));
    var intBoi = int.parse(spaces);
    var structure = string.substring(42, string.indexOf(" - "));
    parkMap.add({
      'structure': structure,
      'spaces': intBoi,
    });
  }

  return json.encode(parkMap);
}