import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';

Future<List<BuffaloModel>> fetchBuffaloes() async {
  try {
    final response = await http.get(
      Uri.parse('${ApiUtils.baseUrl}/api/buffalo/?buffaloStatus=อนุมัติ'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['response_status'] == 'SUCCESS') {
        List<dynamic> farmsList = jsonResponse['data'];
        print(farmsList);
        return farmsList.map((json) => BuffaloModel.fromJson(json)).toList();
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    // ใช้ catch เพื่อจัดการข้อผิดพลาดและแสดงข้อความข้อผิดพลาด
    throw Exception('Failed to load buffaloes: $e');
  }
}

Future<List<BuffaloModel>> fetchHistoryBuffaloes() async {
  try {
    final response = await http.get(
      Uri.parse(
          '${ApiUtils.baseUrl}/api/buffalo/history/?buffaloStatus=อนุมัติ&farmId=-1'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['response_status'] == 'SUCCESS') {
        List<dynamic> farmsList = jsonResponse['data'];
        print(farmsList);
        return farmsList.map((json) => BuffaloModel.fromJson(json)).toList();
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    // ใช้ catch เพื่อจัดการข้อผิดพลาดและแสดงข้อความข้อผิดพลาด
    throw Exception('Failed to load buffaloes: $e');
  }
}

Future<List<BuffaloModel>> fetchAllBuffaloes() async {
  try {
    final response = await http.get(
      Uri.parse(
          '${ApiUtils.baseUrl}/api/buffalo/?buffaloStatus=อนุมัติ&farmId=-1'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['response_status'] == 'SUCCESS') {
        List<dynamic> farmsList = jsonResponse['data'];
        print(farmsList);
        return farmsList.map((json) => BuffaloModel.fromJson(json)).toList();
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    // ใช้ catch เพื่อจัดการข้อผิดพลาดและแสดงข้อความข้อผิดพลาด
    throw Exception('Failed to load buffaloes: $e');
  }
}

Future<List<BuffaloModel>> fetchBuffaloesPromoteBuff() async {
  final response = await http
      .get(Uri.parse('${ApiUtils.baseUrl}/api/buffalo/getPromoteBuff'));

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
  final response = await http.get(Uri.parse(
      '${ApiUtils.baseUrl}/api/buffalo/?farmId=$id&buffaloStatus=อนุมัติ'));

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
  required String? fatherName,
  required String? fatherFarmName,
  required String? motherName,
  required String? motherFarmName,
  required String? fatherGrandfatherName,
  required String? fatherGrandfatherFarmName,
  required String? fatherGrandmotherName,
  required String? fatherGrandmotherFarmName,
  required String? motherGrandfatherName,
  required String? motherGrandfatherFarmName,
  required String? motherGrandmotherName,
  required String? motherGrandmotherFarmName,
  required String? fatherGreatGrandfatherName,
  required String? fatherGreatGrandfatherFarmName,
  required String? fatherGreatGrandmotherName,
  required String? fatherGreatGrandmotherFarmName,
  required String? motherGreatGrandfatherName,
  required String? motherGreatGrandfatherFarmName,
  required String? motherGreatGrandmotherName,
  required String? motherGreatGrandmotherFarmName,
  required String bornAt,
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
  request.fields['bornAt'] = bornAt;

  request.fields['fatherName'] = fatherName ?? '';
  request.fields['fatherFarmName'] = fatherFarmName ?? '';

  request.fields['motherName'] = motherName ?? '';
  request.fields['motherFarmName'] = motherFarmName ?? '';

  request.fields['fatherGrandfatherName'] = fatherGrandfatherName ?? '';
  request.fields['fatherGrandfatherFarmName'] = fatherGrandfatherFarmName ?? '';

  request.fields['fatherGrandmotherName'] = fatherGrandmotherName ?? '';
  request.fields['fatherGrandmotherFarmName'] = fatherGrandmotherFarmName ?? '';

  request.fields['motherGrandfatherName'] = motherGrandfatherName ?? '';
  request.fields['motherGrandfatherFarmName'] = motherGrandfatherFarmName ?? '';

  request.fields['motherGrandmotherName'] = motherGrandmotherName ?? '';
  request.fields['motherGrandmotherFarmName'] = motherGrandmotherFarmName ?? '';

  request.fields['fatherGreatGrandfatherName'] =
      fatherGreatGrandfatherName ?? '';
  request.fields['fatherGreatGrandfatherFarmName'] =
      fatherGreatGrandfatherFarmName ?? '';

  request.fields['fatherGreatGrandmotherName'] =
      fatherGreatGrandmotherName ?? '';
  request.fields['fatherGreatGrandmotherFarmName'] =
      fatherGreatGrandmotherFarmName ?? '';

  request.fields['motherGreatGrandfatherName'] =
      motherGreatGrandfatherName ?? '';
  request.fields['motherGreatGrandfatherFarmName'] =
      motherGreatGrandfatherFarmName ?? '';

  request.fields['motherGreatGrandmotherName'] =
      motherGreatGrandmotherName ?? '';
  request.fields['motherGreatGrandmotherFarmName'] =
      motherGreatGrandmotherFarmName ?? '';

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
    } else {
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
  // required String videoUrl,
  required String title,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/buffaloClips/';
  final uri = Uri.parse(url);
  final request = http.MultipartRequest('POST', uri);



  // เพิ่มข้อมูลฟิลด์ต่าง ๆ ที่จะส่งไปพร้อมกัน
  request.fields['buffaloId'] = buffaloId.toString();
  request.fields['password'] = password;
  request.fields['farmId'] = farmId.toString();
  request.fields['url'] = url;
  // request.fields['videoUrl'] = videoUrl;  // ส่ง URL ของวิดีโอ
  request.fields['title'] = title;        // ส่งชื่อของวิดีโอ

  // เช็คว่า imageFile ไม่ใช่ null และเพิ่มไฟล์วิดีโอใน request
  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path,));
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      if (responseData['message'] != null) {
        return responseData['message'].toString();
      } else {
        throw Exception('Farm data not found.');
      }
    } else {
      throw Exception(
        'Failed to upload video. Status code: ${response.statusCode}. Response body: ${response.body}',
      );
    }
  } catch (e) {
    throw Exception('Failed to upload video: $e');
  }
}

Future<String> updateBuffalo({
  required String name,
  required String buffaloId,
  required String birthDate,
  required String farmId,
  required String birthMethod,
  required String gender,
  required String? fatherName,
  required String? fatherFarmName,
  required String? motherName,
  required String? motherFarmName,
  required String? fatherGrandfatherName,
  required String? fatherGrandfatherFarmName,
  required String? fatherGrandmotherName,
  required String? fatherGrandmotherFarmName,
  required String? motherGrandfatherName,
  required String? motherGrandfatherFarmName,
  required String? motherGrandmotherName,
  required String? motherGrandmotherFarmName,
  required String? fatherGreatGrandfatherName,
  required String? fatherGreatGrandfatherFarmName,
  required String? fatherGreatGrandmotherName,
  required String? fatherGreatGrandmotherFarmName,
  required String? motherGreatGrandfatherName,
  required String? motherGreatGrandfatherFarmName,
  required String? motherGreatGrandmotherName,
  required String? motherGreatGrandmotherFarmName,
  required String bornAt,
  required String color,
  required String password,
}) async {
  String url = '${ApiUtils.baseUrl}/api/buffalo/update/$buffaloId';
  final uri = Uri.parse(url);
  final request = http.MultipartRequest('PUT', uri);

  DateTime? selectedDate = DateFormat('dd/MM/yyyy').parse(birthDate);
  String formattedDate = formatDateForBackend(selectedDate);
  request.fields['name'] = name;
  request.fields['birthDate'] = formattedDate;
  request.fields['farmId'] = Uri.encodeComponent(farmId);
  request.fields['gender'] = gender;
  request.fields['birthMethod'] = birthMethod;
  request.fields['color'] = color;
  request.fields['bornAt'] = bornAt;

  request.fields['fatherName'] = fatherName ?? '';
  request.fields['fatherFarmName'] = fatherFarmName ?? '';

  request.fields['motherName'] = motherName ?? '';
  request.fields['motherFarmName'] = motherFarmName ?? '';

  request.fields['fatherGrandfatherName'] = fatherGrandfatherName ?? '';
  request.fields['fatherGrandfatherFarmName'] = fatherGrandfatherFarmName ?? '';

  request.fields['fatherGrandmotherName'] = fatherGrandmotherName ?? '';
  request.fields['fatherGrandmotherFarmName'] = fatherGrandmotherFarmName ?? '';

  request.fields['motherGrandfatherName'] = motherGrandfatherName ?? '';
  request.fields['motherGrandfatherFarmName'] = motherGrandfatherFarmName ?? '';

  request.fields['motherGrandmotherName'] = motherGrandmotherName ?? '';
  request.fields['motherGrandmotherFarmName'] = motherGrandmotherFarmName ?? '';

  request.fields['fatherGreatGrandfatherName'] =
      fatherGreatGrandfatherName ?? '';
  request.fields['fatherGreatGrandfatherFarmName'] =
      fatherGreatGrandfatherFarmName ?? '';

  request.fields['fatherGreatGrandmotherName'] =
      fatherGreatGrandmotherName ?? '';
  request.fields['fatherGreatGrandmotherFarmName'] =
      fatherGreatGrandmotherFarmName ?? '';

  request.fields['motherGreatGrandfatherName'] =
      motherGreatGrandfatherName ?? '';
  request.fields['motherGreatGrandfatherFarmName'] =
      motherGreatGrandfatherFarmName ?? '';

  request.fields['motherGreatGrandmotherName'] =
      motherGreatGrandmotherName ?? '';
  request.fields['motherGreatGrandmotherFarmName'] =
      motherGreatGrandmotherFarmName ?? '';

  request.fields['password'] = password;

  // Send the request
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData['message'] != null && responseData['message'] != null) {
      print(responseData);
      return responseData['message'].toString(); // Return the farmId
    } else {
      throw Exception('Farm data not found.');
    }
  } else {
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}
