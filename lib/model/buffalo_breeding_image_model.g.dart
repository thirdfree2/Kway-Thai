// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_breeding_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloBreedingImageModel _$BuffaloBreedingImageModelFromJson(
  Map<String, dynamic> json,
) =>
    BuffaloBreedingImageModel(
      buffaloBreedingImageId: (json['BuffaloBreedingImageId'] as num).toInt(),
      imageType: json['imageType'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$BuffaloBreedingImageModelToJson(
  BuffaloBreedingImageModel instance,
) =>
    <String, dynamic>{
      'BuffaloBreedingImageId': instance.buffaloBreedingImageId,
      'imageType': instance.imageType,
      'imageUrl': instance.imageUrl,
    };
