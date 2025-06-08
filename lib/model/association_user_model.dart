import 'package:json_annotation/json_annotation.dart';

part 'association_user_model.g.dart';

@JsonSerializable()
class AssociationUserModel {
  final int associationUserId;

  @JsonKey(defaultValue: '')
  final String firstName;

  @JsonKey(defaultValue: '')
  final String lastName;

  @JsonKey(defaultValue: '')
  final String nickname;

  @JsonKey(defaultValue: '')
  final String lineId;

  @JsonKey(defaultValue: '')
  final String phoneNumber;

  @JsonKey(defaultValue: '')
  final String position;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: '')
  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;
  final int associationId;

  AssociationUserModel({
    required this.associationUserId,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.lineId,
    required this.phoneNumber,
    required this.position,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.associationId,
  });

  factory AssociationUserModel.fromJson(Map<String, dynamic> json) =>
      _$AssociationUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationUserModelToJson(this);
}
