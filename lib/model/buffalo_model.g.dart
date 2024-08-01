// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloModel _$BuffaloModelFromJson(Map<String, dynamic> json) => BuffaloModel(
      id: (json['buffaloId'] as num).toInt(),
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      birthMethod: json['birthMethod'] as String,
      fatherId: (json['fatherId'] as num?)?.toInt(),
      motherId: (json['motherId'] as num?)?.toInt(),
      grandfatherId: (json['grandfatherId'] as num?)?.toInt(),
      grandmotherId: (json['grandmotherId'] as num?)?.toInt(),
      greatGrandfatherId: (json['greatGrandfatherId'] as num?)?.toInt(),
      greatGrandmotherId: (json['greatGrandmotherId'] as num?)?.toInt(),
      currentFarmId: (json['currentFarmId'] as num?)?.toInt(),
      farmId: (json['farmId'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      farm: json['farm'] == null
          ? null
          : FarmModel.fromJson(json['farm'] as Map<String, dynamic>),
      currentFarm: json['currentFarm'] == null
          ? null
          : FarmModel.fromJson(json['currentFarm'] as Map<String, dynamic>),
      father: json['father'] == null
          ? null
          : BuffaloModel.fromJson(json['father'] as Map<String, dynamic>),
      mother: json['mother'] == null
          ? null
          : BuffaloModel.fromJson(json['mother'] as Map<String, dynamic>),
      grandfather: json['grandfather'] == null
          ? null
          : BuffaloModel.fromJson(json['grandfather'] as Map<String, dynamic>),
      grandmother: json['grandmother'] == null
          ? null
          : BuffaloModel.fromJson(json['grandmother'] as Map<String, dynamic>),
      greatGrandfather: json['greatGrandfather'] == null
          ? null
          : BuffaloModel.fromJson(
              json['greatGrandfather'] as Map<String, dynamic>),
      greatGrandmother: json['greatGrandmother'] == null
          ? null
          : BuffaloModel.fromJson(
              json['greatGrandmother'] as Map<String, dynamic>),
      buffaloImages: json['BuffaloImages'] as List<dynamic>? ?? const [],
      buffaloBreedingImages:
          json['BuffaloBreedingImages'] as List<dynamic>? ?? const [],
      histories: json['Histories'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$BuffaloModelToJson(BuffaloModel instance) =>
    <String, dynamic>{
      'buffaloId': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'birthMethod': instance.birthMethod,
      'fatherId': instance.fatherId,
      'motherId': instance.motherId,
      'grandfatherId': instance.grandfatherId,
      'grandmotherId': instance.grandmotherId,
      'greatGrandfatherId': instance.greatGrandfatherId,
      'greatGrandmotherId': instance.greatGrandmotherId,
      'currentFarmId': instance.currentFarmId,
      'farmId': instance.farmId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'farm': instance.farm?.toJson(),
      'currentFarm': instance.currentFarm?.toJson(),
      'father': instance.father?.toJson(),
      'mother': instance.mother?.toJson(),
      'grandfather': instance.grandfather?.toJson(),
      'grandmother': instance.grandmother?.toJson(),
      'greatGrandfather': instance.greatGrandfather?.toJson(),
      'greatGrandmother': instance.greatGrandmother?.toJson(),
      'BuffaloImages': instance.buffaloImages,
      'BuffaloBreedingImages': instance.buffaloBreedingImages,
      'Histories': instance.histories,
    };
