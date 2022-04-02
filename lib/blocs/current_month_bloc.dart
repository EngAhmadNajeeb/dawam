import 'package:dawam/models/current_month.dart';
import 'package:dawam/providers/api_entry.dart';
import 'package:dawam/providers/api_months.dart';
import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rxdart/rxdart.dart';

class CurrentMonthBloc {
  final _currentMonthController = PublishSubject<CurrentMonth>();

  get currentMonthStream => _currentMonthController.stream;

  Future<void> getCurrentMonth(BuildContext context) async {
    await ApiMonths(context).getCurrentMonth().then((webSer) {
      if (webSer != null) {
        _currentMonthController.sink
            .add(CurrentMonth.fromMap(Map<String, dynamic>.from(webSer.data)));
      }
    });
  }

  signInput(BuildContext context, bool isInput) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiEntry(context).signInput(isInput).then((webSer) {
        if (webSer != null) {
          getCurrentMonth(context).then((_) => progressDialog.hide());
        }
      });
    });
  }

  void dispose() {
    _currentMonthController.close();
  }
}
