import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/model/farm_model.dart';

Future<String> registerFarm({
  required String farmName,
  required String region,
  required String lineId,
  required String phoneNumber,
  required String password,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/farm/';
  final Map<String, dynamic> requestData = {
    'farmName': farmName,
    'region': region,
    'lineId': lineId,
    'phoneNumber': phoneNumber,
    'password': password,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestData),
  );
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['data'] != null &&
        responseData['data']['farmId'] != null) {
      return responseData['data']['farmId'].toString(); // ส่งคืนค่า farmId
    } else {
      throw Exception('เบอร์โทรศัพท์ถูกใช้แล้ว');
    }
  } else {
    throw Exception(
        'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}

Future<List<FarmModel>> fetchFarmsByRegion(String region) async {
  final response = await http.get(
      Uri.parse('${ApiUtils.baseUrl}/api/farm/byregionandname?farmStatus=อนุมัติ&region=$region'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['response_status'] == 'SUCCESS') {
      List<dynamic> farmsList = jsonResponse['data'];
      print(farmsList);
      return farmsList.map((json) => FarmModel.fromJson(json)).toList();
    } else {
      throw Exception('API response status is not SUCCESS');
    }
  } else {
    throw Exception('Failed to load farms');
  }
}

Future<String> updateFarm({
  required String farmName,
  // required String region,
  // required String lineId,
  // required String phoneNumber,
  // required String password,
  required String farmId,
}) async {
  String url = '${ApiUtils.baseUrl}/api/farm/$farmId';

  final Map<String, dynamic> requestData = {
    'farmName': farmName,
    // 'password': password,
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
    if (responseData['message'] != null &&
        responseData['message'] != null) {
      return responseData['message'].toString(); // ส่งคืนค่า farmId
    } else {
      throw Exception('เบอร์โทรศัพท์ถูกใช้แล้ว');
    }
  } else {
    throw Exception(
        'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}

Future<List<FarmModel>> fetchFarmsNorth() => fetchFarmsByRegion('เหนือ');
Future<List<FarmModel>> fetchFarmsNortheast() => fetchFarmsByRegion('อีสาน');
Future<List<FarmModel>> fetchFarmsCentral() => fetchFarmsByRegion('กลาง');
Future<List<FarmModel>> fetchFarmsSouth() => fetchFarmsByRegion('ใต้');
Future<List<FarmModel>> fetchFarmsWest() => fetchFarmsByRegion('ตะวันตก');
Future<List<FarmModel>> fetchFarmsEast() => fetchFarmsByRegion('ตะวันออก');
