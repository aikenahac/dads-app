import 'package:json_annotation/json_annotation.dart';

part 'album_image.model.g.dart';

@JsonSerializable()
class AlbumImage {
  final String url;

  AlbumImage(this.url);

  factory AlbumImage.fromJson(Map<String, dynamic> json) => _$AlbumImageFromJson(json);
}
