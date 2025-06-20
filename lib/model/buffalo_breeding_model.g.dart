// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_breeding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloBreedingModel _$BuffaloBreedingModelFromJson(
  Map<String, dynamic> json,
) =>
    BuffaloBreedingModel(
      buffaloBreedingId: (json['buffaloBreedingId'] as num).toInt(),
      maleName: json['maleName'] as String,
      breedingMethod: json['breedingMethod'] as String,
      breedingCount: (json['breedingCount'] as num).toInt(),
      recheckDate: DateTime.parse(json['recheckDate'] as String),
      expectedBirthDate: DateTime.parse(json['expectedBirthDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      buffaloId: (json['buffaloId'] as num).toInt(),
      buffaloBreedingImages: (json['BuffaloBreedingImages'] as List<dynamic>?)
              ?.map(
                (e) => BuffaloBreedingImageModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      breedingDate: DateTime.parse(json['breedingDate'] as String),
    );

Map<String, dynamic> _$BuffaloBreedingModelToJson(
  BuffaloBreedingModel instance,
) =>
    <String, dynamic>{
      'buffaloBreedingId': instance.buffaloBreedingId,
      'maleName': instance.maleName,
      'breedingMethod': instance.breedingMethod,
      'breedingCount': instance.breedingCount,
      'recheckDate': instance.recheckDate.toIso8601String(),
      'expectedBirthDate': instance.expectedBirthDate.toIso8601String(),
      'breedingDate': instance.breedingDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'buffaloId': instance.buffaloId,
      'BuffaloBreedingImages': instance.buffaloBreedingImages,
    };
