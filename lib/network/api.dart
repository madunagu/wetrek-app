import 'dart:convert';

import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wetrek/network/exceptions.dart';

class API {
  static String _rootURL = 'https://devotion.wakabout.com.ng/api';
  // String _rootURL = 'http://10.0.2.2:8000/api';
  static String token;
  static bool isTokenGotten = false;

  static Future<dynamic> getToken() async {
//    var userRepo = UserRepository();
//    this.token = await userRepo.getToken();
    API.isTokenGotten = true;
  }

  static Map<String, String> headers() {
    return {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
  }

  static Map<String, dynamic> prepareResponse(http.Response httpResponse) {
    log(httpResponse.body.toString());
    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      return jsonDecode(httpResponse.body);
    } else if (httpResponse.statusCode == 422) {
      throw ValidationErrorException(errors: jsonDecode(httpResponse.body));
    } else if (httpResponse.statusCode == 401) {
      throw AuthenticationException();
    } else if (httpResponse.statusCode >= 400 &&
        httpResponse.statusCode < 500) {
      throw ClientErrorException();
    } else if (httpResponse.statusCode >= 500 &&
        httpResponse.statusCode < 600) {
      throw ServerErrorException();
    }
    throw UnknownException();
  }

  static Future<Map<String, dynamic>> get(String url) async {
    http.Response response =
        await http.get(_rootURL + url, headers: API.headers());
    log(response.body.toString(), name: 'network.category');
    return prepareResponse(response);
  }

  static Future<Map<String, dynamic>> post(String url, dynamic data) async {
    String jsonData = jsonEncode(data);
    Map<String, String> headers = API.headers();

    http.Response response = await http.post(
      _rootURL + url,
      body: jsonData,
      headers: headers,
    );
    return prepareResponse(response);
  }

  static Future<Map<String, dynamic>> postWithoutToken(
      String url, dynamic data) async {
    String jsonData = jsonEncode(data);
    Map<String, String> headers = API.headers();

    http.Response response = await http.post(
      _rootURL + url,
      body: jsonData,
      headers: headers,
    );
    return prepareResponse(response);
  }

  static Future<Map<String, dynamic>> put(String url, dynamic data) async {
    http.Response response = await http.put(
      _rootURL + url,
      body: jsonEncode(data),
      headers: API.headers(),
    );
    return prepareResponse(response);
  }

  static Future<Map<String, dynamic>> delete(String url) async {
    http.Response response =
        await http.delete(_rootURL + url, headers: API.headers());
    return prepareResponse(response);
  }
}
