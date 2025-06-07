import 'package:buffalo_thai/model/buffalo_vaccine_record_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buffalo_vaccine_model.g.dart';

@JsonSerializable()
class BuffaloVaccineModel {
  final int buffaloVaccineId;

  @JsonKey(defaultValue: 0)
  final int? buffaloId;

  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(
    defaultValue: [],
    name: 'BuffaloVaccineRecords',
  )
  final List<BuffaloVaccineRecordModel> buffaloVaccineRecords;

  BuffaloVaccineModel({
    required this.buffaloVaccineRecords,
    required this.buffaloVaccineId,
    this.buffaloId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BuffaloVaccineModel.fromJson(Map<String, dynamic> json) =>
      _$BuffaloVaccineModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuffaloVaccineModelToJson(this);
}



        // {
        //     "buffaloVaccineId": 1,
        //     "createdAt": "2024-10-13T16:01:53.000Z",
        //     "updatedAt": "2024-10-13T16:01:53.000Z",
        //     "buffaloId": 558,
        //     "BuffaloVaccineRecords": [
        //         {
        //             "buffaloVaccineRecordId": 1,
        //             "vaccineName": "เทส1",
        //             "doseNumber": 1,
        //             "volume": 50,
        //             "injectionDate": "2024-10-13",
        //             "nextInjectionDate": "2024-10-13",
        //             "createdAt": "2024-10-13T16:01:53.000Z",
        //             "updatedAt": "2024-10-13T16:01:53.000Z",
        //             "buffaloVaccineId": 1
        //         },
        //         {
        //             "buffaloVaccineRecordId": 2,
        //             "vaccineName": "เทส1",
        //             "doseNumber": 2,
        //             "volume": 50,
        //             "injectionDate": "2024-10-13",
        //             "nextInjectionDate": "2024-10-13",
        //             "createdAt": "2024-10-13T16:01:53.000Z",
        //             "updatedAt": "2024-10-13T16:01:53.000Z",
        //             "buffaloVaccineId": 1
        //         }
        //     ]
        // },