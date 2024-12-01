import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bootcamp_app/models/space.dart';

class SpaceProvider extends ChangeNotifier {
  Future<List<Space>> getRecommendedSpaces() async {
    var result = await http
        .get(Uri.parse('https://bwa-cozy-api.vercel.app/recommended-spaces'));

    print(result.statusCode);
    print(result.body);

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<Space> spaces = data.map((item) => Space.fromJson(item)).toList();
      return spaces;
    } else {
      return <Space>[];
    }
  }
}
