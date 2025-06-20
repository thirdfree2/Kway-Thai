// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buffalo_tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuffaloTrackingModel _$BuffaloTrackingModelFromJson(
  Map<String, dynamic> json,
) =>
    BuffaloTrackingModel(
      (json['buffaloTrackingId'] as num).toInt(),
      (json['buffaloHeight'] as num?)?.toInt() ?? 0,
      (json['buffaloWeight'] as num?)?.toInt() ?? 0,
      json['agePeriod'] as String? ?? '',
      json['imagePath'] as String? ?? '',
      BuffaloTrackingModel._fromJsonDateTime(json['createdAt'] as String?),
      BuffaloTrackingModel._fromJsonDateTime(json['updatedAt'] as String?),
    );

Map<String, dynamic> _$BuffaloTrackingModelToJson(
  BuffaloTrackingModel instance,
) =>
    <String, dynamic>{
      'buffaloTrackingId': instance.id,
      'buffaloWeight': instance.buffaloWeight,
      'buffaloHeight': instance.buffaloHeight,
      'agePeriod': instance.agePeriod,
      'imagePath': instance.imagePath,
      'createdAt': BuffaloTrackingModel._toJsonDateTime(instance.createdAt),
      'updatedAt': BuffaloTrackingModel._toJsonDateTime(instance.updatedAt),
    };
