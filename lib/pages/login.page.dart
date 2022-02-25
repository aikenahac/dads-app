import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/api/exceptions/bad_request.exception.dart';
import 'package:dads_app/models/login/login_dto.model.dart';
import 'package:dads_app/pages/album.page.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _identifier = TextEditingController();
  final TextEditingController _password = TextEditingController();

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void _showMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    bool _checkFields() {
      if (_identifier.text.length <= 2) {
        _showMessage('Identifier has to be longer than 2 characters');
        return false;
      }

      if (_password.text.length <= 5) {
        _showMessage('Password has to be longer than 5 characters');
        return false;
      }

      return true;
    }

    void _onLogin() async {
      SharedPreferences _storage = await SharedPreferences.getInstance();

      if (!_checkFields()) {
        return;
      }

      final loginDto = LoginDto(
        identifier: _identifier.text,
        password: _password.text,
      );

      try {
        final loginResponseJson = await API.post(
          '/auth/local',
          loginDto.toJson(),
        );

        String token = 'Bearer ' + loginResponseJson['jwt'];

        await _storage.setString('token', token);

        Navigator.of(context).pushReplacementNamed(AlbumPage.routeName);
      } catch (e) {
        if (e is BadRequestException) {
          _showMessage(e.message);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppTheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                cursorWidth: 1.5,
                cursorColor: Colors.white,
                controller: _identifier,
                style: AppTheme.textStyle,
                decoration: AppTheme.loginInputDecoration.copyWith(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  labelText: 'Username or e-mail',
                  labelStyle: AppTheme.textStyle,
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                obscureText: true,
                cursorWidth: 1.5,
                cursorColor: Colors.white,
                controller: _password,
                style: AppTheme.textStyle,
                decoration: AppTheme.loginInputDecoration.copyWith(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  labelText: 'Password',
                  labelStyle: AppTheme.textStyle,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: width * 0.7,
                height: height * 0.06,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppTheme.primary),
                  ),
                  onPressed: _onLogin,
                  child: Text(
                    'Login',
                    style: AppTheme.textStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
