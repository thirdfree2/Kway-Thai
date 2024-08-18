import 'dart:convert';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;

Future<List<BuffaloModel>> fetchBuffaloes() async {
  final response =
      await http.get(Uri.parse('${ApiUtils.baseUrl}/api/buffalo/'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['response_status'] == 'SUCCESS') {
      List<dynamic> farmsList = jsonResponse['data'];
      return farmsList.map((json) => BuffaloModel.fromJson(json)).toList();
    } else {
      throw Exception('API response status is not SUCCESS');
    }
  } else {
    throw Exception('Failed to load buffaloes');
  }
}

Future<List<BuffaloModel>> fetchBuffaloesByFarmId(String id) async {
  final response =
      await http.get(Uri.parse('${ApiUtils.baseUrl}/api/buffalo/?farmId=$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['response_status'] == 'SUCCESS') {
      List<dynamic> farmsList = jsonResponse['data'];
      return farmsList.map((json) => BuffaloModel.fromJson(json)).toList();
    } else {
      throw Exception('API response status is not SUCCESS');
    }
  } else {
    throw Exception('Failed to load buffaloes');
  }
}
