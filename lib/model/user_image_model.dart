import 'package:json_annotation/json_annotation.dart';

part 'user_image_model.g.dart';

@JsonSerializable()
class UserImageModel {
  UserImageModel({
    required this.imageId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory UserImageModel.fromJson(Map<String, dynamic> json) =>
      _$UserImageModelFromJson(json);
  @JsonKey(name: 'imageId')
  final int imageId;

  @JsonKey(name: 'imageUrl', defaultValue: '')
  final String imageUrl;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'userId')
  final int userId;
  Map<String, dynamic> toJson() => _$UserImageModelToJson(this);
}
