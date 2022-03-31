// import 'package:dawam/ui/widgets/progress_dialog.dart';
import 'package:dawam/utilities/app_colors.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class GeneralWidget {
  static progressIndicator(Stream<bool> isLoadingStream) {
    return StreamBuilder<bool>(
      stream: isLoadingStream,
      initialData: false,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Opacity(
              opacity: snapshot.data! ? 1.0 : 00,
              child: const SpinKitCircle(
                color: AppColors.app,
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }

  static progressDialog(context) {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      isDismissible: false,
    );
    progressDialog.style(
        textAlign: TextAlign.center,
        message: AppLocalizations.of(context)!.trans('please_wait'),
        borderRadius: 10.0,
        backgroundColor: Colors.greenAccent.shade100,
        progressWidget: Transform.scale(
            scale: 0.8,
            child: const CircularProgressIndicator(
              color: AppColors.amber,
              strokeWidth: 3,
            )),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 10.0,
        progressTextStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w500),
        messageTextStyle: TextStyle(
            color: AppColors.black.withOpacity(0.7),
            fontSize: 15.0,
            fontWeight: FontWeight.w800));
    return progressDialog;
  }

  static listProgressIndicator() {
    return const Center(
      child: SpinKitCircle(
        color: AppColors.app, // Colors.yellow[700]
        size: 40,
      ),
    );
  }
}
