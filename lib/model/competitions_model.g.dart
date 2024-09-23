// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsModel _$CompetitionsModelFromJson(Map<String, dynamic> json) =>
    CompetitionsModel(
      competitionId: (json['competitionId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      rank: json['rank'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      type: json['type'] as String? ?? '',
      province: json['province'] as String? ?? '',
      imageBuffalo: json['imageBuffalo'] as String? ?? '',
      date: CompetitionsModel._fromJsonDateTime(json['date'] as String?),
      createdAt:
          CompetitionsModel._fromJsonDateTime(json['createdAt'] as String?),
      updatedAt:
          CompetitionsModel._fromJsonDateTime(json['updatedAt'] as String?),
      buffaloId: (json['buffaloId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CompetitionsModelToJson(CompetitionsModel instance) =>
    <String, dynamic>{
      'competitionId': instance.competitionId,
      'name': instance.name,
      'rank': instance.rank,
      'gender': instance.gender,
      'type': instance.type,
      'province': instance.province,
      'imageBuffalo': instance.imageBuffalo,
      'date': CompetitionsModel._toJsonDateTime(instance.date),
      'createdAt': CompetitionsModel._toJsonDateTime(instance.createdAt),
      'updatedAt': CompetitionsModel._toJsonDateTime(instance.updatedAt),
      'buffaloId': instance.buffaloId,
    };
