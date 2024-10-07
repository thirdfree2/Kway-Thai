import 'dart:convert';

import 'package:buffalo_thai/model/annouce_model.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;

Future<List<AnnouceModel>> fetchAnnouce() async {
  try {
    final response = await http.get(
      Uri.parse('${ApiUtils.baseUrl}/api/annouce/getAll'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['response_status'] == 'ERROR') {
        List<dynamic> farmsList = jsonResponse['data'];
        print(farmsList);
        return farmsList.map((json) => AnnouceModel.fromJson(json)).toList();
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load buffaloes: $e');
  }
}