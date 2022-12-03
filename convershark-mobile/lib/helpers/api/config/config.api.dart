import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

final _storageBox = Hive.box("storageBox");

class ApiClient {
  Map<String, String> getHeaderRequest() {
    Map<String, String> headers = <String, String>{
      "Access-Control-Allow-Origin": "*",
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    dynamic accessToken = _storageBox.get("accessToken");

    if (accessToken != null) {
      headers.addEntries({"Authorization": "$AUTH_TYPES $accessToken"}.entries);
    }

    return headers;
  }

  get(String path) async {
    Map<String, String> headers = getHeaderRequest();
    return http.get(Uri.parse(DOMAIN_API + path), headers: headers);
  }

  post(String path, dynamic body) async {
    Map<String, String> headers = getHeaderRequest();
    return http.post(Uri.parse(DOMAIN_API + path),
        headers: headers, body: jsonEncode(body));
  }

  patch(String path, dynamic body) async {
    Map<String, String> headers = getHeaderRequest();
    return http.patch(Uri.parse(DOMAIN_API + path),
        headers: headers, body: jsonEncode(body));
  }

  delete(String path, dynamic body) async {
    Map<String, String> headers = getHeaderRequest();
    return http.delete(Uri.parse(DOMAIN_API + path),
        headers: headers, body: jsonEncode(body));
  }
}
