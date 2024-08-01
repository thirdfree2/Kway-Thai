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

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'lineId')
  final String? lineId;

  @JsonKey(name: 'position')
  final String position;

  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'farmId')
  final int farmId;

  @JsonKey(name: 'UserImages')
  final List<dynamic> userImages;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    this.lineId,
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
