import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Future loadStaticFile(String assetPath) async {
  var jsonString = await rootBundle.loadString(assetPath);
  var json = jsonDecode(jsonString);
  return json;
}
