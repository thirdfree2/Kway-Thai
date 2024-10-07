import 'package:json_annotation/json_annotation.dart';


part 'annouce_model.g.dart';

@JsonSerializable()
class AnnouceModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'context', defaultValue: '')
  final String context;
  @JsonKey(name: 'filename', defaultValue: '')
  final String filename;
  @JsonKey(name: 'filepath', defaultValue: '')
  final String filepath;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  AnnouceModel(
    this.context,
    this.filename,
    this.filepath, {
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnnouceModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouceModelToJson(this);
}
