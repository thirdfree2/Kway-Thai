import 'package:buffalo_thai/model/user_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'userId')
  final int userId;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;

  @JsonKey(name: 'lineId', defaultValue: '')
  final String? lineId;

  @JsonKey(name: 'position', defaultValue: '')
  final String position;

  @JsonKey(name: 'phoneNumber', defaultValue: '')
  final String? phoneNumber;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'farmId')
  final int farmId;

  @JsonKey(name: 'UserImages', defaultValue: [])
  final List<UserImageModel> userImages;  // Updated type

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.lineId,
    required this.position,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.farmId,
    required this.userImages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
