import 'package:buffalo_thai/model/buffalo_breeding_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buffalo_breeding_model.g.dart';

@JsonSerializable()
class BuffaloBreedingModel {
  BuffaloBreedingModel({
    required this.buffaloBreedingId,
    required this.maleName,
    required this.breedingMethod,
    required this.breedingCount,
    required this.recheckDate,
    required this.expectedBirthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.buffaloId,
    required this.buffaloBreedingImages,
    required this.breedingDate,
  });

  factory BuffaloBreedingModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloBreedingModelFromJson(json);
  @JsonKey(name: 'buffaloBreedingId')
  final int buffaloBreedingId;

  @JsonKey(name: 'maleName')
  final String maleName;

  @JsonKey(name: 'breedingMethod')
  final String breedingMethod;

  @JsonKey(name: 'breedingCount')
  final int breedingCount;

  @JsonKey(name: 'recheckDate')
  final DateTime recheckDate;

  @JsonKey(name: 'expectedBirthDate')
  final DateTime expectedBirthDate;

  @JsonKey(name: 'breedingDate')
  final DateTime breedingDate;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'buffaloId')
  final int buffaloId;

  @JsonKey(name: 'BuffaloBreedingImages', defaultValue: [])
  final List<BuffaloBreedingImageModel> buffaloBreedingImages;
  Map<String, dynamic> toJson() => _$BuffaloBreedingModelToJson(this);
}

            // "buffaloBreedingId": 7,
            // "maleName": "ควายทอง",
            // "breedingMethod": "ผสมเทียม",
            // "breedingCount": 1,
            // "recheckDate": "2025-06-25",
            // "expectedBirthDate": "2026-03-02",
            // "createdAt": "2025-06-06T19:52:48.000Z",
            // "updatedAt": "2025-06-06T19:52:48.000Z",
            // "buffaloId": 514,
            // "BuffaloBreedingImages": [
            //     {
            //         "BuffaloBreedingImageId": 2,
            //         "imageType": "ผสมเทียม",
            //         "imageUrl": "http://localhost:3306/upload/buffalo/image-1749239568803-312222670.jpg"
            //     }
            // ]