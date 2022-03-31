import 'package:dawam/models/api_json_response.dart';
import 'package:dawam/providers/base_provider/api_constants.dart';
import 'package:dawam/providers/base_provider/api_provider.dart';
import 'package:dawam/utilities/enums.dart';
import 'package:flutter/material.dart';

class ApiLogin extends ApiProvider {
  ApiLogin(BuildContext context) : super(context);

  Future<ApiJsonResponse?> login(String? userName, String? password) async {
    var body = {
      "username": "$userName",
      "password": "$password",
    };
    debugPrint(body.toString());
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.login), body: body, type: RequestType.post);
    return response;
  }
}
