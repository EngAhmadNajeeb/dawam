import 'package:dawam/models/auth_data.dart';
import 'package:dawam/providers/api_login.dart';
import 'package:dawam/ui/pages/splash.dart';
import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class LoginBloc {
  String? username;
  String? password;

  bool _checkIsValid(BuildContext context) {
    if ((username ?? "").isEmpty || (password ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("please_fill_all"));
      return false;
    }
    return true;
  }

  login(context) {
    FocusScope.of(context).unfocus();
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiLogin(context).login(username, password).then((res) {
          progressDialog.hide();
          if (res != null) {
            dataStore
                .saveAuthData(AuthData.fromMap(res.data).toJson())
                .then((isSet) {
              if (isSet) {
                dataStore.loadAuthData().then((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Splash(),
                      ));
                });
              }
            });
          }
        });
      });
    }
  }
}
