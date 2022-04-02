import 'package:dawam/utilities/data_store.dart';
import 'package:intl/intl.dart';

class AppConsts {
  DateFormat dayNameFormat = DateFormat("EEE ", dataStore.lang);
  DateFormat ddMMFormat = DateFormat("dd / MM", "en");
  DateFormat monthNameFormat = DateFormat("MMM ", dataStore.lang);
  static DateFormat mmyyyyFormat = DateFormat("MM / yyyy");
  static DateFormat yearFormat = DateFormat("yyyy");
  DateFormat timeFormat = DateFormat("hh:mm:ss");
  DateFormat h12Format = DateFormat(" a", dataStore.lang);
}
