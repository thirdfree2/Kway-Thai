import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/model/user_model.dart';


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
}) async {
  const String url = '${ApiUtils.baseUrl}/api/user/';

  final request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields['firstName'] = firstName
    ..fields['lastName'] = lastName
    ..fields['nickname'] = nickname
    ..fields['position'] = position
    ..fields['phoneNumber'] = phoneNumber
    ..fields['farmId'] = farmId
    ..fields['lineId'] = lineId
     ..fields['password'] = password
    ..files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile?.path ?? '',
      contentType: MediaType('image', basename(imageFile?.path ?? '').split('.').last),
    ));

  final response = await request.send();

  if (response.statusCode == 201) {
    final responseData = await response.stream.bytesToString();
    print(responseData);
    return responseData;
  } else {
    final responseData = await response.stream.bytesToString();
    throw Exception(
        'Failed to register farm owner. Status code: ${response.statusCode}. Response body: $responseData');
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
        'Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}
