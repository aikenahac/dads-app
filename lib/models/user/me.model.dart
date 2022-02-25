import 'package:dads_app/models/user/profile_picture.model.dart';
import 'package:dads_app/models/user/user_family.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'me.model.g.dart';

@JsonSerializable()
class Me {
  final int id;
  final String firstName, lastName, username, email;
  final ProfilePicture profilePicture;
  final UserFamily family;

  Me(
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.profilePicture,
    this.family,
  );

  factory Me.fromJson(Map<String, dynamic> json) => _$MeFromJson(json);
}
