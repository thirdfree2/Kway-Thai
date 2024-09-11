// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloModel _$BuffaloModelFromJson(Map<String, dynamic> json) => BuffaloModel(
      json['fatherName'] as String? ?? '',
      (json['fatherGrandfatherId'] as num?)?.toInt(),
      json['fatherGrandfatherName'] as String? ?? '',
      (json['fatherGrandmotherId'] as num?)?.toInt(),
      json['fatherGrandmotherName'] as String? ?? '',
      (json['motherGrandfatherId'] as num?)?.toInt(),
      json['motherGrandfatherName'] as String? ?? '',
      (json['motherGrandmotherId'] as num?)?.toInt(),
      json['motherGrandmotherName'] as String? ?? '',
      (json['fatherGreatGrandfatherId'] as num?)?.toInt(),
      json['fatherGreatGrandfatherName'] as String? ?? '',
      (json['fatherGreatGrandmotherId'] as num?)?.toInt(),
      json['motherGreatGrandfatherName'] as String? ?? '',
      (json['motherGreatGrandmotherId'] as num?)?.toInt(),
      json['motherGreatGrandmotherName'] as String? ?? '',
      json['motherName'] as String? ?? '',
      id: (json['buffaloId'] as num).toInt(),
      name: json['name'] as String? ?? '',
      birthMethod: json['birthMethod'] as String? ?? '',
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      fatherId: (json['fatherId'] as num?)?.toInt(),
      motherId: (json['motherId'] as num?)?.toInt(),
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
      buffaloImages: (json['BuffaloImages'] as List<dynamic>?)
              ?.map(
                  (e) => BuffaloImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      buffaloBreedingImages:
          json['BuffaloBreedingImages'] as List<dynamic>? ?? [],
      histories: json['Histories'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$BuffaloModelToJson(BuffaloModel instance) =>
    <String, dynamic>{
      'buffaloId': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'birthMethod': instance.birthMethod,
      'fatherId': instance.fatherId,
      'fatherName': instance.fatherName,
      'fatherGrandfatherId': instance.fatherGrandfatherId,
      'fatherGrandfatherName': instance.fatherGrandfatherName,
      'fatherGrandmotherId': instance.fatherGrandmotherId,
      'fatherGrandmotherName': instance.fatherGrandmotherName,
      'motherGrandfatherId': instance.motherGrandfatherId,
      'motherGrandfatherName': instance.motherGrandfatherName,
      'motherGrandmotherId': instance.motherGrandmotherId,
      'motherGrandmotherName': instance.motherGrandmotherName,
      'fatherGreatGrandfatherId': instance.fatherGreatGrandfatherId,
      'fatherGreatGrandfatherName': instance.fatherGreatGrandfatherName,
      'fatherGreatGrandmotherId': instance.fatherGreatGrandmotherId,
      'motherGreatGrandfatherName': instance.motherGreatGrandfatherName,
      'motherGreatGrandmotherId': instance.motherGreatGrandmotherId,
      'motherGreatGrandmotherName': instance.motherGreatGrandmotherName,
      'motherId': instance.motherId,
      'motherName': instance.motherName,
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
      'BuffaloImages': instance.buffaloImages.map((e) => e.toJson()).toList(),
      'BuffaloBreedingImages': instance.buffaloBreedingImages,
      'Histories': instance.histories,
    };
