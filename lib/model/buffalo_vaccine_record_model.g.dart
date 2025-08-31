// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_vaccine_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloVaccineRecordModel _$BuffaloVaccineRecordModelFromJson(
        Map<String, dynamic> json) =>
    BuffaloVaccineRecordModel(
      buffaloVaccineRecordId: (json['buffaloVaccineRecordId'] as num).toInt(),
      vaccineName: json['vaccineName'] as String? ?? '',
      buffaloId: (json['buffaloId'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      doseNumber: (json['doseNumber'] as num?)?.toInt() ?? 0,
      volume: (json['volume'] as num?)?.toInt() ?? 0,
      injectionDate: DateTime.parse(json['injectionDate'] as String),
      nextInjectionDate: DateTime.parse(json['nextInjectionDate'] as String),
    );

Map<String, dynamic> _$BuffaloVaccineRecordModelToJson(
        BuffaloVaccineRecordModel instance) =>
    <String, dynamic>{
      'buffaloVaccineRecordId': instance.buffaloVaccineRecordId,
      'vaccineName': instance.vaccineName,
      'buffaloId': instance.buffaloId,
      'doseNumber': instance.doseNumber,
      'volume': instance.volume,
      'injectionDate': instance.injectionDate.toIso8601String(),
      'nextInjectionDate': instance.nextInjectionDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
