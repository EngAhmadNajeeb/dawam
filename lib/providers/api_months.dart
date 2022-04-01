import 'package:dawam/models/api_json_response.dart';
import 'package:dawam/providers/base_provider/api_constants.dart';
import 'package:dawam/providers/base_provider/api_provider.dart';
import 'package:flutter/material.dart';

class ApiMonths extends ApiProvider {
  ApiMonths(BuildContext context) : super(context);
  Future<ApiJsonResponse?> getCurrentMonth() async {
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.current));
    return response;
  }
}
