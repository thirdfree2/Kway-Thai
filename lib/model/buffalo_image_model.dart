


import 'package:json_annotation/json_annotation.dart';

part 'buffalo_image_model.g.dart';

@JsonSerializable()
class BuffaloImageModel {
  @JsonKey(name: 'imageId')
  final int imageId;
  @JsonKey(name: 'imagePath')
  final String imagePath;
  @JsonKey(name: 'isProfileImage')
  final bool isProfileImage;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'buffaloId')
  final int buffaloId;

  BuffaloImageModel({
    required this.imageId,
    required this.imagePath,
    required this.isProfileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.buffaloId,
  });

  factory BuffaloImageModel.fromJson(Map<String, dynamic> json) => _$BuffaloImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuffaloImageModelToJson(this);
}
