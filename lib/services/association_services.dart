import 'dart:convert';
import 'dart:io';

import 'package:buffalo_thai/model/association_model.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;

Future<List<AssociationModel>> fetchAssociation() async {
  try {
    final response = await http.get(
      Uri.parse('${ApiUtils.baseUrl}/api/associations/'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse['response_status'] == 'SUCCESS') {
        List<dynamic> associationList = jsonResponse['data'];
        return associationList
            .map((json) => AssociationModel.fromJson(json))
            .toList();
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load buffaloes: $e');
  }
}

Future<AssociationModel> fetchAssociationById({required String id}) async {
  try {
    final uri = Uri.parse('${ApiUtils.baseUrl}/api/associations/$id');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse['response_status'] == 'SUCCESS') {
        Map<String, dynamic> associationJson = jsonResponse['data'];
        final model = AssociationModel.fromJson(associationJson);

        return model;
      } else {
        throw Exception('API response status is not SUCCESS');
      }
    } else {
      throw Exception('Failed to load buffaloes: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load buffaloes: $e');
  }
}

Future<String> registerAssociationUser({
  required int associationId,
  required String password,
  required String firstName,
  required String lastName,
  required String nickname,
  required String lineId,
  required String phoneNumber,
  required String position,
  required File profileImage,
}) async {
  final uri = Uri.parse('${ApiUtils.baseUrl}/api/associations/user');

  var request = http.MultipartRequest('POST', uri);

  request.fields['associationId'] = associationId.toString();
  request.fields['password'] = password;
  request.fields['firstName'] = firstName;
  request.fields['lastName'] = lastName;
  request.fields['nickname'] = nickname;
  request.fields['lineId'] = lineId;
  request.fields['phoneNumber'] = phoneNumber;
  request.fields['position'] = position;

  request.fields['status'] = 'ไม่อนุมัติ';

  request.files.add(
    await http.MultipartFile.fromPath('profileimage', profileImage.path),
  );

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
      '❌ Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}

Future<String> updateAssociationUser({
  required String associationUserId,
  required int associationId,
  required String password,
  required String firstName,
  required String lastName,
  required String nickname,
  required String lineId,
  required String phoneNumber,
  required String position,
  File? profileImage,
}) async {
  final uri =
      Uri.parse('${ApiUtils.baseUrl}/api/associations/user/$associationUserId');

  var request = http.MultipartRequest('PUT', uri);

  request.fields['associationId'] = associationId.toString();
  request.fields['password'] = password;
  request.fields['firstName'] = firstName;
  request.fields['lastName'] = lastName;
  request.fields['nickname'] = nickname;
  request.fields['lineId'] = lineId;
  request.fields['phoneNumber'] = phoneNumber;
  request.fields['position'] = position;

  if (profileImage != null) {
    request.files.add(
      await http.MultipartFile.fromPath('profileimage', profileImage.path),
    );
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
      '❌ Failed to register farm owner. Status code: ${response.statusCode}. Response body: ${response.body}',
    );
  }
}
