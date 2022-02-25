import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/activity_list_item.model.dart';
import 'package:dads_app/models/user/me.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getFamilyActivities() async {
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
