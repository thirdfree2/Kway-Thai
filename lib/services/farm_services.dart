import 'dart:convert';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:buffalo_thai/model/farm_model.dart';

Future<List<FarmModel>> fetchFarmsByRegion(String region) async {
  final response = await http.get(Uri.parse('${ApiUtils.baseUrl}/api/farm/byregionandname?region=$region'));

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

Future<List<FarmModel>> fetchFarmsNorth() => fetchFarmsByRegion('เหนือ');
Future<List<FarmModel>> fetchFarmsNortheast() => fetchFarmsByRegion('อีสาน');
Future<List<FarmModel>> fetchFarmsCentral() => fetchFarmsByRegion('กลาง');
Future<List<FarmModel>> fetchFarmsSouth() => fetchFarmsByRegion('ใต้');
Future<List<FarmModel>> fetchFarmsWest() => fetchFarmsByRegion('ตะวันตก');
Future<List<FarmModel>> fetchFarmsEast() => fetchFarmsByRegion('ตะวันออก');
