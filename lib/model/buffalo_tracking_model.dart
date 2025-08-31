import 'package:json_annotation/json_annotation.dart';

part 'buffalo_tracking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuffaloTrackingModel {
  // ถูก ✅
  factory BuffaloTrackingModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloTrackingModelFromJson(json);
  BuffaloTrackingModel(
    this.id,
    this.buffaloHeight,
    this.buffaloWeight,
    this.chestGirth,
    this.bodyLength,
    this.agePeriod,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  );
  @JsonKey(name: 'buffaloTrackingId')
  final int id;

  @JsonKey(name: 'buffaloWeight', defaultValue: 0)
  final int buffaloWeight;

  @JsonKey(name: 'buffaloHeight', defaultValue: 0)
  final int buffaloHeight;

  @JsonKey(name: 'chestGirth', defaultValue: 0)
  final int? chestGirth;

  @JsonKey(name: 'bodyLength', defaultValue: 0)
  final int? bodyLength;

  @JsonKey(name: 'agePeriod', defaultValue: '')
  final String agePeriod;

  @JsonKey(name: 'imagePath', defaultValue: '')
  final String imagePath;

  @JsonKey(
    name: 'createdAt',
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? createdAt;

  @JsonKey(
    name: 'updatedAt',
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? updatedAt;

  static DateTime? _fromJsonDateTime(String? date) =>
      date != null ? DateTime.parse(date) : null;

  static String? _toJsonDateTime(DateTime? date) => date?.toIso8601String();
  Map<String, dynamic> toJson() => _$BuffaloTrackingModelToJson(this);
}
