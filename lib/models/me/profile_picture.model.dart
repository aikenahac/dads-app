import 'package:json_annotation/json_annotation.dart';

part 'profile_picture.model.g.dart';

@JsonSerializable()
class ProfilePicture {
  final int id;
  final String url;

  ProfilePicture(
    this.id,
    this.url,
  );

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => _$ProfilePictureFromJson(json);
}
