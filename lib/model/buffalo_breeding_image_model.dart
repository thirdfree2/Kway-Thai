import 'package:json_annotation/json_annotation.dart';

part 'buffalo_breeding_image_model.g.dart';

@JsonSerializable()
class BuffaloBreedingImageModel {
  factory BuffaloBreedingImageModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloBreedingImageModelFromJson(json);

  BuffaloBreedingImageModel({
    required this.buffaloBreedingImageId,
    required this.imageType,
    required this.imageUrl,
  });
  @JsonKey(name: 'BuffaloBreedingImageId')
  final int buffaloBreedingImageId;
  @JsonKey(name: 'imageType')
  final String imageType;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  Map<String, dynamic> toJson() => _$BuffaloBreedingImageModelToJson(this);
}
