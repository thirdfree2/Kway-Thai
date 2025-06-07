import 'package:json_annotation/json_annotation.dart';

part 'association_model.g.dart';

@JsonSerializable()
class AssociationModel {
  final int associationId;

  @JsonKey(defaultValue: '')
  final String associationName;

  final DateTime createdAt;
  final DateTime updatedAt;

  AssociationModel({
    required this.associationId,
    required this.associationName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) =>
      _$AssociationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationModelToJson(this);
}
