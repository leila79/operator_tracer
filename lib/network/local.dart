import 'dart:convert';
import 'package:flutter/services.dart';

class LocalApiHelper {
  Future<String> _loadFromAsset(String fileName) async {
    return await rootBundle.loadString("assets/data/" + fileName + ".json");
  }

  Future<dynamic> parseJson(String fileName) async {
    String jsonString = await _loadFromAsset(fileName);
    final jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }
}
