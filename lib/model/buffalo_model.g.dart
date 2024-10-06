// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloModel _$BuffaloModelFromJson(Map<String, dynamic> json) => BuffaloModel(
      json['fatherFarmName'] as String? ?? '',
      json['fatherGrandfatherFarmName'] as String? ?? '',
      json['fatherGrandmotherFarmName'] as String? ?? '',
      json['motherFarmName'] as String? ?? '',
      json['motherGrandfatherFarmName'] as String? ?? '',
      json['motherGrandmotherFarmName'] as String? ?? '',
      json['fatherGreatGrandfatherFarmName'] as String? ?? '',
      json['fatherGreatGrandmotherFarmName'] as String? ?? '',
      json['motherGreatGrandfatherFarmName'] as String? ?? '',
      json['motherGreatGrandmotherFarmName'] as String? ?? '',
      id: (json['buffaloId'] as num).toInt(),
      name: json['name'] as String? ?? '',
      birthMethod: json['birthMethod'] as String? ?? '',
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      fatherId: (json['fatherId'] as num?)?.toInt(),
      fatherName: json['fatherName'] as String? ?? '',
      fatherGrandfatherId: (json['fatherGrandfatherId'] as num?)?.toInt(),
      fatherGrandfatherName: json['fatherGrandfatherName'] as String? ?? '',
      fatherGrandmotherId: (json['fatherGrandmotherId'] as num?)?.toInt(),
      fatherGrandmotherName: json['fatherGrandmotherName'] as String? ?? '',
      motherId: (json['motherId'] as num?)?.toInt(),
      motherName: json['motherName'] as String? ?? '',
      motherGrandfatherId: (json['motherGrandfatherId'] as num?)?.toInt(),
      motherGrandfatherName: json['motherGrandfatherName'] as String? ?? '',
      motherGrandmotherId: (json['motherGrandmotherId'] as num?)?.toInt(),
      motherGrandmotherName: json['motherGrandmotherName'] as String? ?? '',
      fatherGreatGrandfatherId:
          (json['fatherGreatGrandfatherId'] as num?)?.toInt(),
      fatherGreatGrandfatherName:
          json['fatherGreatGrandfatherName'] as String? ?? '',
      fatherGreatGrandmotherId:
          (json['fatherGreatGrandmotherId'] as num?)?.toInt(),
      fatherGreatGrandmotherName:
          json['fatherGreatGrandmotherName'] as String? ?? '',
      motherGreatGrandfatherId:
          (json['motherGreatGrandfatherId'] as num?)?.toInt(),
      motherGreatGrandfatherName:
          json['motherGreatGrandfatherName'] as String? ?? '',
      motherGreatGrandmotherId:
          (json['motherGreatGrandmotherId'] as num?)?.toInt(),
      motherGreatGrandmotherName:
          json['motherGreatGrandmotherName'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      color: json['color'] as String? ?? '',
      buffaloStatus: json['buffaloStatus'] as String? ?? '',
      bornAt: json['bornAt'] as String? ?? '',
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
      buffaloClips: (json['BuffaloClips'] as List<dynamic>?)
              ?.map((e) => BuffaloClipModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      histories: json['Histories'] as List<dynamic>? ?? [],
      competitions: (json['Competitions'] as List<dynamic>?)
              ?.map(
                  (e) => CompetitionsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BuffaloModelToJson(BuffaloModel instance) =>
    <String, dynamic>{
      'buffaloId': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'birthMethod': instance.birthMethod,
      'gender': instance.gender,
      'color': instance.color,
      'fatherId': instance.fatherId,
      'fatherName': instance.fatherName,
      'fatherFarmName': instance.fatherFarmName,
      'fatherGrandfatherId': instance.fatherGrandfatherId,
      'fatherGrandfatherName': instance.fatherGrandfatherName,
      'fatherGrandfatherFarmName': instance.fatherGrandfatherFarmName,
      'fatherGrandmotherId': instance.fatherGrandmotherId,
      'fatherGrandmotherName': instance.fatherGrandmotherName,
      'fatherGrandmotherFarmName': instance.fatherGrandmotherFarmName,
      'motherId': instance.motherId,
      'motherName': instance.motherName,
      'motherFarmName': instance.motherFarmName,
      'motherGrandfatherId': instance.motherGrandfatherId,
      'motherGrandfatherName': instance.motherGrandfatherName,
      'motherGrandfatherFarmName': instance.motherGrandfatherFarmName,
      'motherGrandmotherId': instance.motherGrandmotherId,
      'motherGrandmotherName': instance.motherGrandmotherName,
      'motherGrandmotherFarmName': instance.motherGrandmotherFarmName,
      'fatherGreatGrandfatherId': instance.fatherGreatGrandfatherId,
      'fatherGreatGrandfatherName': instance.fatherGreatGrandfatherName,
      'fatherGreatGrandfatherFarmName': instance.fatherGreatGrandfatherFarmName,
      'fatherGreatGrandmotherId': instance.fatherGreatGrandmotherId,
      'fatherGreatGrandmotherName': instance.fatherGreatGrandmotherName,
      'fatherGreatGrandmotherFarmName': instance.fatherGreatGrandmotherFarmName,
      'motherGreatGrandfatherId': instance.motherGreatGrandfatherId,
      'motherGreatGrandfatherName': instance.motherGreatGrandfatherName,
      'motherGreatGrandfatherFarmName': instance.motherGreatGrandfatherFarmName,
      'motherGreatGrandmotherId': instance.motherGreatGrandmotherId,
      'motherGreatGrandmotherName': instance.motherGreatGrandmotherName,
      'motherGreatGrandmotherFarmName': instance.motherGreatGrandmotherFarmName,
      'buffaloStatus': instance.buffaloStatus,
      'bornAt': instance.bornAt,
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
      'BuffaloClips': instance.buffaloClips.map((e) => e.toJson()).toList(),
      'Histories': instance.histories,
      'Competitions': instance.competitions.map((e) => e.toJson()).toList(),
    };
