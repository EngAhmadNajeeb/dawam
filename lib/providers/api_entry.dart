import 'package:dawam/models/api_json_response.dart';
import 'package:dawam/providers/base_provider/api_constants.dart';
import 'package:dawam/providers/base_provider/api_provider.dart';
import 'package:dawam/utilities/enums.dart';
import 'package:flutter/material.dart';

class ApiEntry extends ApiProvider {
  ApiEntry(BuildContext context) : super(context);
  Future<ApiJsonResponse?> signInput(bool isInput) async {
    var body = {"isInput": isInput};
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.entries),
      body: body,
      type: RequestType.post,
    );
    return response;
  }
}
