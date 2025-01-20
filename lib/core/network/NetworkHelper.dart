import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/models/NetworkResponse.dart';
import '../mixins/logging_mixin.dart';

class NetworkHelper with LoggingMixin{
  static NetworkHelper? _instance;
  static late http.Client client;

  factory NetworkHelper() {
    _instance ??= NetworkHelper._internal();
    client = http.Client();
    return _instance!;
  }

  NetworkHelper._internal();

  static NetworkHelper get instance {
    return NetworkHelper();
  }

  Future<NetworkResponse> postCall(
      {required Uri url,
      Map<String, String>? headers,
      required Map<String, dynamic> body}) async {
    late NetworkResponse networkResponse;
    try {
      logEvent("URL:: $url BODY:: $body HEADERS:: $headers");
      var response = await client.post(url, headers: headers, body: jsonEncode(body));
      logEvent(response.toString());
      if (response.statusCode == 200) {
        networkResponse = NetworkResponse.success(
            responseMessage: 'Success!!', response: jsonDecode(response.body));
      } else {
        networkResponse = NetworkResponse.error(
            response: jsonDecode(response.body), responseMessage: 'Error!!');
      }
    } catch (e) {
      networkResponse =
          NetworkResponse.error(response: null, responseMessage: e.toString());
    }
    return networkResponse;
  }

  Future<NetworkResponse> putCall(
      {required Uri url,
        Map<String, String>? headers,
        required Map<String, dynamic> body}) async {
    late NetworkResponse networkResponse;
    try {
      logEvent("URL:: $url BODY:: $body HEADERS:: $headers");
      var response = await client.put(url, headers: headers, body: jsonEncode(body));
      logEvent(response.toString());
      if (response.statusCode == 200) {
        networkResponse = NetworkResponse.success(
            responseMessage: 'Success!!', response: jsonDecode(response.body));
      } else {
        networkResponse = NetworkResponse.error(
            response: jsonDecode(response.body), responseMessage: 'Error!!');
      }
    } catch (e) {
      networkResponse =
          NetworkResponse.error(response: null, responseMessage: e.toString());
    }
    return networkResponse;
  }


  Future<NetworkResponse> getCall(
      {required Uri url, Map<String, String>? headers}) async {
    late NetworkResponse networkResponse;
    try {
      logEvent("URL:: $url HEADERS:: $headers");
      var response = await client.get(url, headers: headers);
      logEvent(response.body);
      if (response.statusCode == 200) {
        networkResponse = NetworkResponse.success(
            responseMessage: 'Success!!', response: jsonDecode(response.body));
      } else {
        networkResponse = NetworkResponse.error(
            response: jsonDecode(response.body), responseMessage: 'Error!!');
      }
    } catch (e) {
      networkResponse =
          NetworkResponse.error(response: null, responseMessage: e.toString());
    }
    return networkResponse;
  }
}
