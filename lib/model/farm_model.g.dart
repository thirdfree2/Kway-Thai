// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmModel _$FarmModelFromJson(Map<String, dynamic> json) => FarmModel(
      farmId: (json['farmId'] as num).toInt(),
      farmName: json['farmName'] as String,
      region: json['region'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      lineId: json['lineId'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FarmModelToJson(FarmModel instance) => <String, dynamic>{
      'farmId': instance.farmId,
      'farmName': instance.farmName,
      'region': instance.region,
      'phoneNumber': instance.phoneNumber,
      'lineId': instance.lineId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
