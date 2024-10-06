import 'dart:convert';

import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;

Future<List<UserModel>> fetchUserByFarmId(String id) async {
  final response =
      await http.get(Uri.parse('${ApiUtils.baseUrl}/api/user/?farmId=$id&status=อนุมัติ'));

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

Future<String> updateUser({
  required String firstName,
  required String userId,
  required String lastName,
  required String nickname,
  required String position,
  required String phoneNumber,
  required String farmId,
  required String lineId,
  required String password,
}) async {
  String url = '${ApiUtils.baseUrl}/api/user/$userId';

  final request = http.MultipartRequest('PUT', Uri.parse(url))
    ..fields['firstName'] = firstName
    ..fields['lastName'] = lastName
    ..fields['nickname'] = nickname
    ..fields['position'] = position
    ..fields['phoneNumber'] = phoneNumber
    ..fields['lineId'] = lineId

    ..fields['farmId'] = farmId
    ..fields['password'] = password;

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    print(responseData);
    return responseData;
  } else {
    final responseData = await response.stream.bytesToString();
    throw Exception(
        'Failed to register farm owner. Status code: ${response.statusCode}. Response body: $responseData');
  }
}