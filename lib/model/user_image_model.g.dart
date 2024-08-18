// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImageModel _$UserImageModelFromJson(Map<String, dynamic> json) =>
    UserImageModel(
      imageId: (json['imageId'] as num).toInt(),
      imageUrl: json['imageUrl'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$UserImageModelToJson(UserImageModel instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'userId': instance.userId,
    };
