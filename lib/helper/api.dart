import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Api {
  static var mainUrl = "https://api-entrance-test.infraedukasi.com/";

  static Future connectionApi(
      String typeConnect, valFormData, String url, headerData) async {
    var getUrl = mainUrl + url;
    if (typeConnect == "post" || typeConnect == "patch") {
      try {
        var url = Uri.parse(getUrl);
        if (typeConnect == "post") {
          var response = await post(url,
              body: jsonEncode(valFormData), headers: headerData);
          return response;
        } else if (typeConnect == "patch") {
          var response = await patch(url,
              body: jsonEncode(valFormData), headers: headerData);
          return response;
        }
      } on SocketException catch (e) {
        print(e);
        return false;
      }
    } else {
      try {
        var url = Uri.parse(getUrl);
        var response = await get(url, headers: headerData);
        return response;
      } on SocketException {
        return false;
      }
    }
  }
}
