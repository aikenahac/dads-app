import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/me/me.model.dart';
import 'package:dads_app/pages/album.page.dart';
import 'package:dads_app/pages/login.page.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  _checkLogin() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    if (token != null) {
      Navigator.of(context).pushNamed(AlbumPage.routeName);
    } else {
      Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.secondary,
        child: Center(
          child: Text(
            'Dad\'s App',
            style: AppTheme.textStyle.copyWith(
              fontSize: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
