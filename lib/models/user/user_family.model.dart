import 'package:json_annotation/json_annotation.dart';

part 'user_family.model.g.dart';

@JsonSerializable()
class UserFamily {
  final int id;
  final String name;

  UserFamily(
    this.id,
    this.name,
  );

  factory UserFamily.fromJson(Map<String, dynamic> json) => _$UserFamilyFromJson(json);
}
