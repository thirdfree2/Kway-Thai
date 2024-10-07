// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annouce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouceModel _$AnnouceModelFromJson(Map<String, dynamic> json) => AnnouceModel(
      json['context'] as String? ?? '',
      json['filename'] as String? ?? '',
      json['filepath'] as String? ?? '',
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AnnouceModelToJson(AnnouceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'context': instance.context,
      'filename': instance.filename,
      'filepath': instance.filepath,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
