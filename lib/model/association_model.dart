import 'package:buffalo_thai/model/association_user_model.dart';
import 'package:buffalo_thai/model/farm_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'association_model.g.dart';

@JsonSerializable()
class AssociationModel {
  AssociationModel({
    required this.associationId,
    required this.associationName,
    required this.createdAt,
    required this.updatedAt,
    required this.password,
    required this.approveType,
    required this.associationUsers,
    required this.farms,
    this.associationImage,
  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) =>
      _$AssociationModelFromJson(json);
  final int associationId;

  @JsonKey(defaultValue: '')
  final String associationName;

  @JsonKey(defaultValue: '') // ✅ ทำให้แน่ใจว่าไม่ crash
  final String password;

  @JsonKey(defaultValue: '')
  final String approveType;

  @JsonKey(defaultValue: '')
  final String? associationImage;

  @JsonKey(fromJson: _parseDateTime)
  final DateTime? createdAt;

  @JsonKey(fromJson: _parseDateTime)
  final DateTime? updatedAt;

  static DateTime? _parseDateTime(String? value) =>
      value == null ? null : DateTime.parse(value);

  @JsonKey(defaultValue: [])
  final List<AssociationUserModel> associationUsers;

  @JsonKey(defaultValue: [])
  final List<FarmModel> farms;
  Map<String, dynamic> toJson() => _$AssociationModelToJson(this);
}



// "password": "1234",
//             "approveType": "อนุมัติ",