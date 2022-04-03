import 'package:dawam/models/month.dart';
import 'package:dawam/providers/api_months.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MonthBloc {
  final _monthController = PublishSubject<Month>();
  get monthStream => _monthController.stream;

  Future<void> getMonth(BuildContext context, int monthId) async {
    await ApiMonths(context).geMonth(monthId).then((webSer) {
      if (webSer != null) {
        _monthController.sink
            .add(Month.fromMap(Map<String, dynamic>.from(webSer.data)));
      }
    });
  }

  void dispose() {
    _monthController.close();
  }
}
