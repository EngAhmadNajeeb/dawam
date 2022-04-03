import 'package:dawam/utilities/app_local.dart';

class SecondsExtract {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  SecondsExtract(int totalSeconds) {
    hours = (totalSeconds.abs() / 3600).floor();
    minutes = ((totalSeconds.abs() % 3600) / 60).floor();
    seconds = (totalSeconds.abs() % 3600) % 60;
  }

  String toStringWithType1(context) {
    return "$hours" +
        AppLocalizations.of(context)!.trans('hour') +
        " : $minutes" +
        AppLocalizations.of(context)!.trans('minute') +
        " : $seconds" +
        AppLocalizations.of(context)!.trans('seconds');
  }

  String toStringWithType2(context) {
    return "$hours" +
        AppLocalizations.of(context)!.trans('hour') +
        " : $minutes" +
        AppLocalizations.of(context)!.trans('minute');
  }

  @override
  String toString() {
    return "$hours : $minutes : $seconds";
  }
}
