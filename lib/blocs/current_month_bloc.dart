import 'package:dawam/models/current_month.dart';
import 'package:dawam/providers/api_months.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CurrentMonthBloc {
  final _currentMonthController = PublishSubject<CurrentMonth>();

  get currentMonthStream => _currentMonthController.stream;

  final _isLoadingController = PublishSubject<bool>();

  get isLoadingStream => _isLoadingController.stream;

  getCurrentMonth(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiMonths(context).getCurrentMonth().then((webSer) {
      if (webSer != null) {
        if (!_currentMonthController.isClosed) {
          _currentMonthController.sink.add(
              CurrentMonth.fromMap(Map<String, dynamic>.from(webSer.data)));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _currentMonthController.close();
    _isLoadingController.close();
  }
}
