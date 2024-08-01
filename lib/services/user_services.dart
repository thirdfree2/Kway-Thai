import 'dart:convert';

import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;

Future<List<UserModel>> fetchUserByFarmId(String id) async {
  final response =
      await http.get(Uri.parse('${ApiUtils.baseUrl}/api/user/?farmId=$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print(response.body);
    if (jsonResponse['response_status'] == 'SUCCESS') {
      List<dynamic> farmsList = jsonResponse['data'];
      return farmsList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('API response status is not SUCCESS');
    }
  } else {
    throw Exception('Failed to load buffaloes');
  }
}