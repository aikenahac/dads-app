import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/activity/activity_list_item.model.dart';
import 'package:dads_app/models/album/album_image.model.dart';
import 'package:dads_app/models/album/album_photo.model.dart';
import 'package:dads_app/models/album/album_photo_id.model.dart';
import 'package:dads_app/models/me/me.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ActivityListItem>> getFamilyActivities() async {
  SharedPreferences _storage = await SharedPreferences.getInstance();

  final String token = _storage.getString('token') ??
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQ1Nzk5ODYxLCJleHAiOjE2NDgzOTE4NjF9.nrTx9kzXHEf4MXA_mGLZ2pe0XRmOsMDvb-RUXroQ8J8';

  _storage.setString('token', token);

  final _meJson = await API.get('/users/me');

  Me _me = Me.fromJson(_meJson);

  final _familyJson = await API.get('/families/${_me.family.id}?populate=*');

  final List<ActivityListItem> _activities = List.from(
    _familyJson['data']['attributes']['activities']['data'],
  ).map((e) {
    return ActivityListItem.fromJson(e);
  }).toList();

  return _activities;
}

Future<List<AlbumPhoto>> getFamilyAlbum() async {
  List<AlbumPhoto> _album = [];

  SharedPreferences _storage = await SharedPreferences.getInstance();

  final String token = _storage.getString('token') ??
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQ1Nzk5ODYxLCJleHAiOjE2NDgzOTE4NjF9.nrTx9kzXHEf4MXA_mGLZ2pe0XRmOsMDvb-RUXroQ8J8';

  _storage.setString('token', token);

  final _meJson = await API.get('/users/me');

  Me _me = Me.fromJson(_meJson);

  _storage.setInt('family', _me.family.id);
  _storage.setInt('me', _me.id);

  final _familyJson = await API.get('/families/${_me.family.id}?populate=*');

  final List<AlbumPhotoID> _albumPhotosIDs = List.from(
    _familyJson['data']['attributes']['album']['data'],
  ).map((e) {
    return AlbumPhotoID.fromJson(e);
  }).toList();

  for (AlbumPhotoID photo in _albumPhotosIDs) {
    final _image = await API.get('/photos/${photo.id}?populate=image');

    final AlbumImage _albumImage = AlbumImage.fromJson(_image['data']['attributes']['image']['data']['attributes']);

    final AlbumPhoto _photo = AlbumPhoto(photo.id, _albumImage);

    _album.add(_photo);
  }

  return _album;
}
