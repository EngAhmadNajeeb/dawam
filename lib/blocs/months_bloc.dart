import 'package:dawam/models/month.dart';
import 'package:dawam/providers/api_months.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MonthsBloc {
  List<Month> months = [];
  int page = 1;
  bool isLast = false;
  final _monthsController = PublishSubject<List<Month>>();
  get monthStream => _monthsController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  getMonths(BuildContext context) {
    if (!isLast) {
      _isLoadingController.sink.add(true);
      ApiMonths(context).geAllMonth(page).then((webSer) {
        if (webSer != null) {
          months.addAll(List<Month>.from(
              webSer.data['content'].map((x) => Month.fromMap(x))));
          _monthsController.sink.add(months);
          isLast = webSer.data['last'];
          _isLoadingController.sink.add(false);
        }
      });
    }
  }

  void dispose() {
    _monthsController.close();
    _isLoadingController.close();
  }
}
