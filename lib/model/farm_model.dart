import 'package:buffalo_thai/model/association_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'farm_model.g.dart';

@JsonSerializable()
class FarmModel {
  FarmModel({
    required this.farmId,
    required this.farmName,
    required this.region,
    this.phoneNumber,
    this.lineId,
    required this.createdAt,
    required this.updatedAt,
    required this.associations,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) =>
      _$FarmModelFromJson(json);
  final int farmId;
  final String farmName;
  final String region;

  @JsonKey(defaultValue: '')
  final String? phoneNumber;

  @JsonKey(defaultValue: '')
  final String? lineId;

  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(defaultValue: [])
  final List<AssociationModel> associations;
  Map<String, dynamic> toJson() => _$FarmModelToJson(this);
}
