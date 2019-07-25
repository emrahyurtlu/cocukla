import 'dart:convert';

class ConverterUtility {
  static Map objectToMap(Object object) {
    Map<String, dynamic> result = jsonDecode(jsonEncode(object));
    return result;
  }
}
