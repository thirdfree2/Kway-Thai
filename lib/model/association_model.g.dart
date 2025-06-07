// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationModel _$AssociationModelFromJson(Map<String, dynamic> json) =>
    AssociationModel(
      associationId: (json['associationId'] as num).toInt(),
      associationName: json['associationName'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AssociationModelToJson(AssociationModel instance) =>
    <String, dynamic>{
      'associationId': instance.associationId,
      'associationName': instance.associationName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
