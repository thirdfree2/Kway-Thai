// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloImageModel _$BuffaloImageModelFromJson(Map<String, dynamic> json) =>
    BuffaloImageModel(
      imageId: (json['imageId'] as num).toInt(),
      imagePath: json['imagePath'] as String,
      isProfileImage: json['isProfileImage'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      buffaloId: (json['buffaloId'] as num).toInt(),
    );

Map<String, dynamic> _$BuffaloImageModelToJson(BuffaloImageModel instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imagePath': instance.imagePath,
      'isProfileImage': instance.isProfileImage,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'buffaloId': instance.buffaloId,
    };
