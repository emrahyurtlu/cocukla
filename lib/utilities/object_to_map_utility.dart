import 'dart:convert';

class ConverterUtility {
  static Map ObjecttoMap(Object object) {
    Map<String, dynamic> result = jsonDecode(jsonEncode(object));
    return result;
  }
}
