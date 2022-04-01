import 'package:dawam/utilities/data_store.dart';

class ApiConstants {
  static String authority = dataStore.baseUrl;
  static const String _suffix = "/api/v1/";
  static String login = _suffix + "login";
  static String months = _suffix + "months";
  static String current = months + "/current";
}
