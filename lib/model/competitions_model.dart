import 'package:json_annotation/json_annotation.dart';

part 'competitions_model.g.dart';

@JsonSerializable()
class CompetitionsModel {
  @JsonKey(name: 'competitionId', defaultValue: 0)
  final int competitionId;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'rank', defaultValue: '')
  final String rank;

  @JsonKey(name: 'gender', defaultValue: '')
  final String? gender;

  @JsonKey(name: 'type', defaultValue: '')
  final String? type;

  @JsonKey(name: 'province', defaultValue: '')
  final String? province;

  @JsonKey(name: 'imageBuffalo', defaultValue: '')
  final String? imageBuffalo;

  @JsonKey(name: 'date', fromJson: _fromJsonDateTime, toJson: _toJsonDateTime)
  final DateTime? date;

  @JsonKey(name: 'createdAt', fromJson: _fromJsonDateTime, toJson: _toJsonDateTime)
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt', fromJson: _fromJsonDateTime, toJson: _toJsonDateTime)
  final DateTime? updatedAt;

  @JsonKey(name: 'buffaloId', defaultValue: null)
  final int? buffaloId;

  CompetitionsModel({
    required this.competitionId,
    required this.name,
    required this.rank,
    this.gender,
    this.type,
    this.province,
    this.imageBuffalo,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.buffaloId,
  });

  factory CompetitionsModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionsModelToJson(this);

  static DateTime? _fromJsonDateTime(String? date) =>
      date != null ? DateTime.parse(date) : null;

  static String? _toJsonDateTime(DateTime? date) =>
      date?.toIso8601String();
}
