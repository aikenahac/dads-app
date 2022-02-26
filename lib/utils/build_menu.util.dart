import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/me/me.model.dart';
import 'package:dads_app/pages/login.page.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Me _me;

void _getUser() async {
  _me = Me.fromJson(await API.get('/users/me'));
}

void _handleLogout(BuildContext context) async {
  SharedPreferences _storage = await SharedPreferences.getInstance();

  _storage.clear();

  Navigator.of(context).pushNamed(LoginPage.routeName);
}

Widget buildMenu(BuildContext context) {
  _getUser();

  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 50.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    API.baseUrl + _me.profilePicture.url,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Hello, ${_me.firstName}',
                style: AppTheme.textStyle.copyWith(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
        ListTile(
          onTap: () => _handleLogout(context),
          leading: const Icon(
            Icons.logout,
            size: 20.0,
            color: Colors.white,
          ),
          title: const Text("Logout"),
          textColor: Colors.white,
          dense: true,
        ),
      ],
    ),
  );
}
