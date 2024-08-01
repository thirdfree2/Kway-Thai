import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> registerFarmOwner({
  required String firstName,
  required String lastName,
  required String nickname,
  required String position,
  required String phoneNumber,
  required String farmId,
}) async {
  final String url = '${ApiUtils.baseUrl}/api/user/';
  print('Sending POST request to: $url');

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: {
      'firstName': Uri.encodeComponent(firstName),
      'lastName': Uri.encodeComponent(lastName),
      'nickname': Uri.encodeComponent(nickname),
      'position': Uri.encodeComponent(position),
      'phoneNumber': Uri.encodeComponent(phoneNumber),
      'farmId': Uri.encodeComponent(farmId),
    },
  );

  print('Selected Farm ID: $farmId');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    print('Registration successful');
  } else {
    throw Exception('Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}
