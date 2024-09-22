import 'package:json_annotation/json_annotation.dart';

part 'buffalo_clip_model.g.dart';

@JsonSerializable()
class BuffaloClipModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'imageUrl', defaultValue: '')
  final String imageUrl;
  @JsonKey(name: 'title' ,  defaultValue: '')
  final String title;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'buffaloId',  defaultValue: 0)
  final int buffaloId;

  BuffaloClipModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.buffaloId,
  });

  factory BuffaloClipModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloClipModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuffaloClipModelToJson(this);
}
