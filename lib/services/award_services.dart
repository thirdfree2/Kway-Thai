import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart'; // For handling image uploads

Future<String> addBuffaloAward({
  required int buffaloId,
  required String password,
  required String farmId,
  required String province,
  required String gender,
  required String type,
  required String name,
  required String rank,
  required String date,
  required String color,
  required File image, // Adding image parameter as File type
}) async {
  const String url = '${ApiUtils.baseUrl}/api/competition/create-competition';

  var request = http.MultipartRequest('POST', Uri.parse(url));

  DateTime? selectedDate = DateFormat('dd/MM/yyyy').parse(date);
  String formattedDate = formatDateForBackend(selectedDate);
  request.fields['password'] = password;
  request.fields['farmId'] = farmId.toString();
  request.fields['province'] = province;
  request.fields['buffaloId'] = buffaloId.toString();
  request.fields['gender'] = gender;
  request.fields['type'] = type;
  request.fields['date'] = formattedDate;
  request.fields['name'] = name;
  request.fields['rank'] = rank;
  request.fields['color'] = color;

  request.files
      .add(await http.MultipartFile.fromPath('image', image.path));

  // Send the request
  final response = await request.send();

  if (response.statusCode == 201) {
    final responseData = await http.Response.fromStream(response);
    final jsonResponse = jsonDecode(responseData.body);

    print(jsonResponse);
    if (jsonResponse['data'] != null &&
        jsonResponse['data'] != null) {
      return jsonResponse['data']['farmId'].toString(); // Returning farmId
    } else {
      throw Exception('Error: Duplicate phone number');
    }
  } else {
    throw Exception(
        'Failed to register buffalo award. Status code: ${response.statusCode}. Response body: ${response.reasonPhrase}');
  }
}
