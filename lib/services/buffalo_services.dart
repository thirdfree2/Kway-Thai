import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
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

String formatDateForBackend(DateTime dateTime) {
  // MySQL format: YYYY-MM-DD HH:MM:SS
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

Future<String> registerBuffalo({
  required String name,
  required String birthDate,
  required String farmId,
  required String birthMethod,
  required String gender,
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
  required String color,
  required String password,
  required File? imageFile,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/';
  final uri = Uri.parse(url);
  final request = http.MultipartRequest('POST', uri);

  DateTime? selectedDate = DateFormat('dd/MM/yyyy').parse(birthDate);
  String formattedDate = formatDateForBackend(selectedDate);
  request.fields['name'] = name;
  request.fields['birthDate'] = formattedDate;
  request.fields['farmId'] = Uri.encodeComponent(farmId);
  request.fields['gender'] = gender;
  request.fields['birthMethod'] = birthMethod;
  request.fields['color'] = color;
  request.fields['fatherName'] = fatherName;
  request.fields['motherName'] = motherName;
  request.fields['fatherGrandfatherName'] = fatherGrandfatherName;
  request.fields['fatherGrandmotherName'] = fatherGrandmotherName;
  request.fields['motherGrandfatherName'] = motherGrandfatherName;
  request.fields['motherGrandmotherName'] = motherGrandmotherName;
  request.fields['fatherGreatGrandfatherName'] = fatherGreatGrandfatherName;
  request.fields['fatherGreatGrandmotherName'] = fatherGreatGrandmotherName;
  request.fields['motherGreatGrandfatherName'] = motherGreatGrandfatherName;
  request.fields['motherGreatGrandmotherName'] = motherGreatGrandmotherName;
  request.fields['password'] = password;

  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
  }

  // Send the request
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    if (responseData['buffalo'] != null &&
        responseData['buffalo']['farmId'] != null) {
      return responseData['buffalo']['farmId'].toString(); // Return the farmId
    } else {
      throw Exception('Farm data not found.');
    }
  } else {
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}

Future<String> uploadImageBuffalo({
  required int buffaloId,
  required File? imageFile,
  required String password,
  required String farmId,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/insertImage';
  final uri = Uri.parse(url);
  final request = http.MultipartRequest('POST', uri);

  request.fields['buffaloId'] = buffaloId.toString();
  request.fields['password'] = password;
  request.fields['farmId'] = farmId.toString();
  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
  }

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    if (responseData['message'] != null) {
      return responseData['message'].toString();
    }
    else {
      throw Exception('Farm data not found.');
    }
  } else {
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}


Future<String> uploadVideoBuffalo({
  required int buffaloId,
  required File? imageFile,
  required String password,
  required String farmId,
  required String url,
  required String title,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/buffaloClips/';
  final uri = Uri.parse(url);
  final request = http.MultipartRequest('POST', uri);

  request.fields['buffaloId'] = buffaloId.toString();
  request.fields['url'] = url;
  request.fields['title'] = title;
  request.fields['password'] = password;
  request.fields['farmId'] = farmId.toString();
  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
  }

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    if (responseData['message'] != null) {
      return responseData['message'].toString();
    }
    else {
      throw Exception('Farm data not found.');
    }
  } else {
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}
