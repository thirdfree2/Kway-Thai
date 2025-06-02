import 'package:json_annotation/json_annotation.dart';

part 'buffalo_tracking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuffaloTrackingModel {
  @JsonKey(name: 'buffaloTrackingId')
  final int id;

  @JsonKey(name: 'buffaloWeight', defaultValue: 0)
  final int buffaloWeight;

  @JsonKey(name: 'buffaloHeight', defaultValue: 0)
  final int buffaloHeight;

  @JsonKey(name: 'agePeriod', defaultValue: '')
  final String agePeriod;

  @JsonKey(name: 'imagePath', defaultValue: '')
  final String imagePath;

  @JsonKey(
      name: 'createdAt', fromJson: _fromJsonDateTime, toJson: _toJsonDateTime)
  final DateTime? createdAt;

  @JsonKey(
      name: 'updatedAt', fromJson: _fromJsonDateTime, toJson: _toJsonDateTime)
  final DateTime? updatedAt;

  BuffaloTrackingModel(
    this.id,
    this.buffaloHeight,
    this.buffaloWeight,
    this.agePeriod,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  );

  static DateTime? _fromJsonDateTime(String? date) =>
      date != null ? DateTime.parse(date) : null;

  static String? _toJsonDateTime(DateTime? date) => date?.toIso8601String();
  // ถูก ✅
  factory BuffaloTrackingModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloTrackingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuffaloTrackingModelToJson(this);
}
