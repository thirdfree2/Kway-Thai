import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';

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

Future<String> registerBuffalo({
  required String name,
  required String birthDate,
  required String farmId,
  required String birthMethod,
  required String fatherName,
  required String motherName,
  required String fatherGrandfatherName,
  required String fatherGrandmotherName,
  required String motherGrandfatherName,
  required String motherGrandmotherName,
  required String fatherGreatGrandfatherName,
  required String fatherGreatGrandmotherName,
  required String motherGreatGrandfatherName,
  required String motherGreatGrandmotherName,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/';
  final Map<String, dynamic> requestData = {
    'name': name,
    'birthDate': birthDate,
    'farmId': Uri.encodeComponent(farmId),
    'birthMethod': birthMethod,
    'fatherName': fatherName,
    'motherName': motherName,
    'fatherGrandfatherName': fatherGrandfatherName,
    'fatherGrandmotherName': fatherGrandmotherName,
    'motherGrandfatherName': motherGrandfatherName,
    'motherGrandmotherName': motherGrandmotherName,
    'fatherGreatGrandfatherName': fatherGreatGrandfatherName,
    'fatherGreatGrandmotherName': fatherGreatGrandmotherName,
    'motherGreatGrandfatherName': motherGreatGrandfatherName,
    'motherGreatGrandmotherName': motherGreatGrandmotherName,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 201) {
  final responseData = jsonDecode(response.body);
  print(responseData);
  if (responseData['buffalo'] != null && responseData['buffalo']['farmId'] != null) {
    print(responseData);
    return responseData['buffalo']['farmId'].toString(); // ส่งคืนค่า farmId
  } else {
    throw Exception('ไม่พบข้อมูลฟาร์ม');
  }
} else {
  throw Exception(
    'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
  );
}

}
