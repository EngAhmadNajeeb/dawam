import 'dart:async';
import 'dart:convert';
import 'package:dawam/models/api_json_response.dart';
import 'package:dawam/providers/base_provider/api_constants.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:dawam/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiProvider {
  BuildContext context;
  ApiProvider(this.context);

  Future<bool> _checkIsInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      return false;
    }
    return false;
  }

  Uri getUri(String target, [Map? queryParameters]) {
    if (queryParameters != null) {
      return Uri.http(ApiConstants.authority, target,
          queryParameters as Map<String, dynamic>?);
    } else {
      return Uri.http(ApiConstants.authority, target);
    }
  }

  _getHeaders() {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "lang": dataStore.lang,
    };
    if (dataStore.authData != null) {
      headers["Authorization"] = dataStore.authData?.token ?? "";
    }
    if (Platform.isAndroid) {
      headers["platform"] = "userandroid";
      headers["device_type"] = "android";
    } else if (Platform.isIOS) {
      headers["platform"] = "userios";
      headers["device_type"] = "ios";
    }
    return headers;
  }

  Future<ApiJsonResponse?> fetchRequest({
    required Uri uri,
    Map? body,
    RequestType type = RequestType.get,
  }) async {
    late http.Response response;
    debugPrint("uri: $uri");
    try {
      bool isConnected = await _checkIsInternetConnected();
      debugPrint("_getHeaders: ${_getHeaders()}");
      if (isConnected) {
        switch (type) {
          case RequestType.get:
            response = await http.get(uri, headers: _getHeaders());
            break;
          case RequestType.post:
            response = await http.post(uri,
                headers: _getHeaders(), body: json.encode(body));
            break;
          case RequestType.put:
            response = await http.put(
              uri,
              headers: _getHeaders(),
              body: json.encode(body),
              encoding: utf8,
            );
            break;
          case RequestType.delete:
            response = await http.delete(uri, headers: _getHeaders());
            break;
          default:
        }
        var res = ApiJsonResponse.fromJson(response.body);
        if (response.statusCode == 200) {
          debugPrint("===================================================");
          debugPrint(response.body);
          return res;
        } else {
          Fluttertoast.showToast(msg: '${res.message}');
          return null;
        }
      } else {
        Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.trans("no_connection"))
            .then((value) {
          Timer.periodic(const Duration(seconds: 3), (timer) {
            exit(0);
          });
        });
        return null;
      }
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
