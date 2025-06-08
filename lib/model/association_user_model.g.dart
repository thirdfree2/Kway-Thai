// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationUserModel _$AssociationUserModelFromJson(
        Map<String, dynamic> json) =>
    AssociationUserModel(
      associationUserId: (json['associationUserId'] as num).toInt(),
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      lineId: json['lineId'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      position: json['position'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      associationId: (json['associationId'] as num).toInt(),
    );

Map<String, dynamic> _$AssociationUserModelToJson(
        AssociationUserModel instance) =>
    <String, dynamic>{
      'associationUserId': instance.associationUserId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'nickname': instance.nickname,
      'lineId': instance.lineId,
      'phoneNumber': instance.phoneNumber,
      'position': instance.position,
      'image': instance.image,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'associationId': instance.associationId,
    };
