import 'dart:convert';
import 'dart:io';

Map<String, dynamic> readFileAsMap(String fileName) {
  String content = File("test/core/sample/$fileName").readAsStringSync();

  return jsonDecode(content);
}
