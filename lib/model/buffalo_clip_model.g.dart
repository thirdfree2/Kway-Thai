// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_clip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloClipModel _$BuffaloClipModelFromJson(Map<String, dynamic> json) =>
    BuffaloClipModel(
      json['url'] as String? ?? '',
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      buffaloId: (json['buffaloId'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BuffaloClipModelToJson(BuffaloClipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'url': instance.url,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'buffaloId': instance.buffaloId,
    };
