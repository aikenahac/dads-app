import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';

import 'package:dads_app/api/exceptions/bad_request.exception.dart';
import 'package:dads_app/api/exceptions/forbidden.exception.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class that holds all the network requests
class API {
  static const String baseUrl = 'https://dapi.aikenahac.com';
  static const String apiUrl = '$baseUrl/api';

  // GET function
  // Retrieves JSON data from the API to the app
  static Future<Map<String, dynamic>> get(String endpoint) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers.addAll({
        'Authorization': token,
      });
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    return responseBody;
  }

  static postPhoto(
    String endpoint,
    XFile imageFile,
  ) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    final url = Uri.parse(apiUrl + endpoint);
    final Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({
        'Authorization': token,
      });
    }

    final stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    String mediaType = '';

    if (imageFile.path.substring(imageFile.path.length - 3) == 'png') {
      mediaType = 'png';
    } else if (imageFile.path.substring(imageFile.path.length - 3) == 'jpg') {
      mediaType = 'jpg';
    } else if (imageFile.path.substring(imageFile.path.length - 4) == 'jpeg') {
      mediaType = 'jpeg';
    }

    int length = await imageFile.length();
    final request = http.MultipartRequest('POST', url);
    final multipartFile = http.MultipartFile(
      'files',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: MediaType('image', mediaType),
    );

    request.files.add(multipartFile);
    request.headers.addAll(headers);
    final response = await request.send();
    final resp = await http.Response.fromStream(response);
    final _json = jsonDecode(resp.body);
    int _imageID = _json[0]['id'];

    final int me = _storage.getInt('me') ?? 2;
    final int family = _storage.getInt('family') ?? 2;

    Map<String, dynamic> _createPhotoBody = {
      'data': {'image': '$_imageID', 'family': family, 'uploader': me}
    };
    await API.post('/photos', _createPhotoBody);
  }

  // POST function
  // Sends JSON data to the app from the API
  // Used for adding new items
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers.addAll({
        'Authorization': token,
      });
    }

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(responseBody['error']['message']);
        case 403:
          throw ForbiddenException(responseBody['error']['message']);
      }
    }

    return responseBody;
  }

  // PUT function
  // Sends JSON data to the app from the API
  // Used for updating existing items
  static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers.addAll({
        'Authorization': token,
      });
    }

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(responseBody['error']['message']);
        case 403:
          throw ForbiddenException(responseBody['error']['message']);
      }
    }

    return responseBody;
  }

  // DELETE function
  // Deletes an existing item from the app
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString('token');

    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers.addAll({
        'Authorization': token,
      });
    }

    final response = await http.delete(
      url,
      headers: headers,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(responseBody['error']['message']);
        case 403:
          throw ForbiddenException(responseBody['error']['message']);
      }
    }

    return responseBody;
  }
}
