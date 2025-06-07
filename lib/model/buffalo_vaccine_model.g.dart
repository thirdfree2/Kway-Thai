// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_vaccine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloVaccineModel _$BuffaloVaccineModelFromJson(Map<String, dynamic> json) =>
    BuffaloVaccineModel(
      buffaloVaccineRecords: (json['BuffaloVaccineRecords'] as List<dynamic>?)
              ?.map((e) =>
                  BuffaloVaccineRecordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      buffaloVaccineId: (json['buffaloVaccineId'] as num).toInt(),
      buffaloId: (json['buffaloId'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BuffaloVaccineModelToJson(
        BuffaloVaccineModel instance) =>
    <String, dynamic>{
      'buffaloVaccineId': instance.buffaloVaccineId,
      'buffaloId': instance.buffaloId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'BuffaloVaccineRecords': instance.buffaloVaccineRecords,
    };
