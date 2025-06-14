import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:buffalo_thai/utils/api_utils.dart';

Future<String> registerFarmOwner({
  required String firstName,
  required String lastName,
  required String nickname,
  required String position,
  required String phoneNumber,
  required String farmId,
  required String lineId,
  required String password,
  required File? imageFile,
  required String status,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/user/';

  final request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields['firstName'] = firstName
    ..fields['lastName'] = lastName
    ..fields['status'] = status
    ..fields['nickname'] = nickname
    ..fields['position'] = position
    ..fields['phoneNumber'] = phoneNumber
    ..fields['farmId'] = farmId
    ..fields['lineId'] = lineId
    ..fields['password'] = password
    ..files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile?.path ?? '',
        contentType:
            MediaType('image', basename(imageFile?.path ?? '').split('.').last),
      ),
    );

  final response = await request.send();

  if (response.statusCode == 201) {
    final responseData = await response.stream.bytesToString();
    return responseData;
  } else {
    final responseData = await response.stream.bytesToString();
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: $responseData',
    );
  }
}

Future<String> registerFarmOwnerV2({
  required String firstName,
  required String lastName,
  required String nickname,
  required String position,
  required String phoneNumber,
  required String farmId,
  required String lineId,
  required String password,
  required File imageFile, // รูปหลัก (จำเป็น)
  File? associationImage, // รูป optional
  required String status,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/user/v2'; // ✅ URL ใหม่

  final request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields['firstName'] = firstName
    ..fields['lastName'] = lastName
    ..fields['nickname'] = nickname
    ..fields['position'] = position
    ..fields['phoneNumber'] = phoneNumber
    ..fields['farmId'] = farmId
    ..fields['lineId'] = lineId
    ..fields['password'] = password
    ..fields['status'] = status;

  // ✅ Profile image (จำเป็น)
  request.files.add(
    await http.MultipartFile.fromPath(
      'profileimage',
      imageFile.path,
      // contentType: _detectMediaType(imageFile.path),
    ),
  );

  // ✅ Association image (optional)
  if (associationImage != null) {
    request.files.add(
      await http.MultipartFile.fromPath(
        'associationimage',
        associationImage.path,
        // contentType: _detectMediaType(associationImage.path),
      ),
    );
  }

  final response = await request.send();

  final responseData = await response.stream.bytesToString();

  if (response.statusCode == 201) {
    return responseData;
  } else {
    throw Exception(
      'Failed to register farm owner. Status: ${response.statusCode}, Body: $responseData',
    );
  }
}

Future<String> registerBuffaloOwner({
  required String farmId,
  required String name,
  required String birthMethod,
  required String birthDate,
}) async {
  const String url = '${ApiUtils.baseUrl}/api/buffalo/';

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: {
      'farmId': Uri.encodeComponent(farmId),
      'name': Uri.encodeComponent(name),
      'birthDate': Uri.encodeComponent(birthDate),
      'birthMethod': Uri.encodeComponent(birthMethod),
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData['userId'];
  } else {
    throw Exception(
      'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}
