import 'package:json_annotation/json_annotation.dart';

part 'album_photo_id.model.g.dart';

@JsonSerializable()
class AlbumPhotoID {
  final int id;

  AlbumPhotoID(this.id);

  factory AlbumPhotoID.fromJson(Map<String, dynamic> json) => _$AlbumPhotoIDFromJson(json);
}
