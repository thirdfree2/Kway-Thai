import 'package:json_annotation/json_annotation.dart';

part 'buffalo_vaccine_record_model.g.dart';

@JsonSerializable()
class BuffaloVaccineRecordModel {
  final int buffaloVaccineRecordId;

  @JsonKey(defaultValue: '')
  final String? vaccineName;

  @JsonKey(defaultValue: 0)
  final int? buffaloId;

  @JsonKey(defaultValue: 0)
  final int? doseNumber;

  @JsonKey(defaultValue: 0)
  final int? volume;

  final DateTime injectionDate;

  final DateTime nextInjectionDate;

  final DateTime createdAt;
  final DateTime updatedAt;

  BuffaloVaccineRecordModel({
    required this.buffaloVaccineRecordId,
    this.vaccineName,
    this.buffaloId,
    required this.createdAt,
    required this.updatedAt,
    this.doseNumber,
    this.volume,
    required this.injectionDate,
    required this.nextInjectionDate,
  });

  factory BuffaloVaccineRecordModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloVaccineRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuffaloVaccineRecordModelToJson(this);
}
