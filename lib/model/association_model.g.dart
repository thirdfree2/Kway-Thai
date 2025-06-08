// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationModel _$AssociationModelFromJson(Map<String, dynamic> json) =>
    AssociationModel(
      associationId: (json['associationId'] as num).toInt(),
      associationName: json['associationName'] as String? ?? '',
      createdAt: AssociationModel._parseDateTime(json['createdAt'] as String?),
      updatedAt: AssociationModel._parseDateTime(json['updatedAt'] as String?),
      password: json['password'] as String? ?? '',
      approveType: json['approveType'] as String? ?? '',
      associationUsers: (json['associationUsers'] as List<dynamic>?)
              ?.map((e) =>
                  AssociationUserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      farms: (json['farms'] as List<dynamic>?)
              ?.map((e) => FarmModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssociationModelToJson(AssociationModel instance) =>
    <String, dynamic>{
      'associationId': instance.associationId,
      'associationName': instance.associationName,
      'password': instance.password,
      'approveType': instance.approveType,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'associationUsers': instance.associationUsers,
      'farms': instance.farms,
    };
