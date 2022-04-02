import 'dart:async';
import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';
import 'package:dawam/models/current_month.dart';

class CurrentMonthCard extends StatefulWidget {
  final CurrentMonth model;
  const CurrentMonthCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  _CurrentMonthCardState createState() => _CurrentMonthCardState();
}

class _CurrentMonthCardState extends State<CurrentMonthCard>
    with WidgetsBindingObserver {
  Timer? timer;
  late SecondsExtract todayFlowTime;
  late SecondsExtract workingTime;
  late SecondsExtract flowWorkingTime;
  late bool isOverTime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    setTimer();
    isOverTime = widget.model.month.flowWorkingSeconds >= 0;
    workingTime = SecondsExtract(widget.model.month.workingSeconds);
    flowWorkingTime = SecondsExtract(widget.model.month.flowWorkingSeconds);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setTimer();
    } else {
      timer?.cancel();
    }
  }

  setTimer() {
    todayFlowTime = SecondsExtract(widget.model.workingSecondsTody);
    if (widget.model.lastEntryTody?.isInput ?? false) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        int over = DateTime.now()
            .difference(DateTime.parse(widget.model.lastEntryTody!.date))
            .inSeconds;
        todayFlowTime = SecondsExtract(widget.model.workingSecondsTody + over);
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    widget.model.month.getMonthName(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Text(
                    widget.model.month.getYear(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!
                          .trans("elapsed_time_today")),
                      Text(
                        todayFlowTime.toString(),
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!
                        .trans("required_working_hours"),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "${widget.model.month.requiredWorkingHours}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.trans(isOverTime
                        ? "overtime_working_hours_until_yesterday"
                        : "uncompleted_working_hours_until_yesterday"),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  flowWorkingTime.toString(),
                  style: TextStyle(
                    color: isOverTime ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!
                        .trans("completed_working_hours_until_today"),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  workingTime.toStringWithType(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
