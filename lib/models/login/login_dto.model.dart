import 'package:json_annotation/json_annotation.dart';

part 'login_dto.model.g.dart';

@JsonSerializable()
class LoginDto {
  final String identifier, password;

  LoginDto({required this.identifier, required this.password});

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
